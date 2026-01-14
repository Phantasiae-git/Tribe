import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tribe/features/auth/presentation/components/my_button.dart';
import 'package:tribe/features/matchmaking/domain/entities/tags.dart';
import 'package:tribe/features/matchmaking/domain/entities/tribe_form.dart';
import 'package:tribe/features/matchmaking/presentation/components/my_range_slider.dart';
import 'package:tribe/features/matchmaking/presentation/components/my_tag_picker.dart';
import 'package:tribe/features/matchmaking/presentation/cubits/form_cubit.dart';
import 'package:tribe/features/matchmaking/presentation/cubits/tribe_form_states.dart';
import 'package:tribe/features/matchmaking/presentation/pages/waitlist_page.dart';

class FindGroupPage extends StatefulWidget {
  final String uid;

  const FindGroupPage({super.key, required this.uid});

  @override
  State<FindGroupPage> createState() => _FindGroupPageState();
}

class _FindGroupPageState extends State<FindGroupPage> {
  //This page should only display if you've already customized your own info in profile

  late List<TagCategory> categories;

  late final formCubit = context.read<TribeFormCubit>();
  //read formSettings cubit as well

  void submitMatch(TribeForm form) async {
    //do any necessary checks to the fields, empty/not selected etc
    formCubit.submitTribeForm(form);
  }

  @override
  void initState() {
    super.initState();

    formCubit.fetchTribeForm(widget.uid);

    categories = [//fetch from formSettings
      TagCategory(
        id: 'category1',
        name: 'Skills',
        tags: [
          Tag(id: 's1', label: 'Cooking'),
          Tag(id: 's2', label: 'Cleaning'),
          Tag(id: 's3', label: 'Finances'),
          Tag(id: 's4', label: 'Sewing'),
        ],
      ),
      TagCategory(
        id: 'category2',
        name: 'Items you\'d like for the group to have',
        tags: [
          Tag(id: 'i1', label: 'TV'),
          Tag(id: 'i2', label: 'Furniture'),
          Tag(id: 'i3', label: 'Playstation'),
          Tag(id: 'i4', label: 'Switch'),
        ],
      ),
      TagCategory(
        id: 'category3',
        name: 'Subscriptions and Services',
        tags: [
          Tag(id: 's1', label: 'Netflix'),
          Tag(id: 's2', label: 'HBO'),
          Tag(id: 's3', label: 'Spotify'),
          Tag(id: 's4', label: 'Steam Family'),
        ],
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TribeFormCubit, TribeFormState>(
      builder: (context, state) {
        if (state is TribeFormUnsubmitted) {
          final form = state.form;
          //final formSettings= state.formSettings;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.people,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Find your Tribe",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyRangeSlider(
                        min: 3,
                        max: 10,
                        values: RangeValues(state.form.minMembers, state.form.maxMembers),
                        onChanged: (range) {
                          formCubit.updateMemberNum(
                            min: range.start,
                            max: range.end,
                          );
                        },
                        label:
                            "How many members should your Tribe have? (including you)",
                      ),
                      const SizedBox(height: 10),
                      MyRangeSlider(
                        min: 18,
                        max: 99,
                        values: RangeValues(
                          state.form.minAge,
                          state.form.maxAge,
                        ),
                        onChanged: (range) {
                          formCubit.updateAgeRange(
                            min: range.start,
                            max: range.end,
                          );
                        },
                        label: "Min and max age of the members",
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: form.okWithPets,
                            onChanged: (newValue) {
                              if(newValue!=null) {
                                formCubit.updateOkWithPets(newValue);
                              }
                            },
                          ),
                          const Text("are you ok with pets?"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Tag Pickers
                      ...categories.map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: MyTagPicker(
                            category: category,
                            selectedTags: state.form.tags[category.id] ?? [],
                            onTagAdded: (tag) {
                              formCubit.addTag(category.id, tag);
                            },
                            onTagRemoved: (tag) {
                              formCubit.removeTag(category.id, tag);
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Review my own information before submitting",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyButton(
                        onTap: () => submitMatch(form),
                        text: "Find your Tribe!",
                      ),
                      const SizedBox(height: 50), // extra bottom padding
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is TribeFormSubmitted) {
          //return waitlistpage
          return WaitlistPage();
        } else if (state is TribeFormLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is TribeFormError) {
          return Text(state.message);
          }else {
          return Text("kys now");
        }
      },
    );
  }
}
