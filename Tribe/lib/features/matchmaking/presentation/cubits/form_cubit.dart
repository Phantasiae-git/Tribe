import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tribe/features/matchmaking/domain/entities/tags.dart';
import 'package:tribe/features/matchmaking/domain/entities/tribe_form.dart';
import 'package:tribe/features/matchmaking/domain/repos/tribe_form_repo.dart';
import 'package:tribe/features/matchmaking/presentation/cubits/tribe_form_states.dart';

class TribeFormCubit extends Cubit<TribeFormState> {
  final TribeFormRepo tribeFormRepo;

  TribeFormCubit({required this.tribeFormRepo}) : super(TribeFormInitial());

  Future<void> fetchTribeForm(String uid) async {
    try {
      emit(TribeFormLoading());
      TribeForm? tribeForm; //change hardcode, get from TribeFormRepo

      if (tribeForm == null) {
        //user doesn't have any TribeForms stored in the database so they have never submitted one
        tribeForm = TribeForm(userID: uid);
        emit(TribeFormUnsubmitted(tribeForm));
      } else {
        emit(TribeFormSubmitted(tribeForm));
      }
    } catch (e) {
      emit(TribeFormError(e.toString()));
    }
  }

  Future<void> submitTribeForm(TribeForm form) async {
    try {
      emit(TribeFormLoading());
      await tribeFormRepo.submitForm(form);
      emit(TribeFormSubmitted(form));
      //change user state variable to waitlist
    } catch (e) {
       emit(TribeFormError(e.toString()));
    }
  }

  void addTag(String categoryId, Tag tag) {
  final state = this.state;

  if (state is! TribeFormUnsubmitted) return;
  final currentForm = state.form;

  final newTags = Map<String, List<Tag>>.from(currentForm.tags);

  newTags[categoryId] = List<Tag>.from(newTags[categoryId] ?? [])
    ..add(tag);

  emit(
    TribeFormUnsubmitted(
      currentForm.copyWith(tags: newTags),
    ),
  );
}

void removeTag(String categoryId, Tag tag) {
    final state = this.state;

    if (state is! TribeFormUnsubmitted) return;

    final currentForm = state.form;

    final newTags = Map<String, List<Tag>>.from(currentForm.tags);

    newTags[categoryId] = List<Tag>.from(
      newTags[categoryId] ?? [],
    )..removeWhere((t) => t.id == tag.id);

    emit(
      TribeFormUnsubmitted(
        currentForm.copyWith(tags: newTags),
      ),
    );
  }

  void updateAgeRange({required double min, required double max}) {
  final state = this.state;
  if (state is! TribeFormUnsubmitted) return;

  emit(
    TribeFormUnsubmitted(
      state.form.copyWith(minAge: min, maxAge: max),
    ),
  );
}

  void updateMemberNum({required double min, required double max}) {
  final state = this.state;
  if (state is! TribeFormUnsubmitted) return;

  emit(
    TribeFormUnsubmitted(
      state.form.copyWith(minMembers: min, maxMembers: max),
    ),
  );
}

  void updateOkWithPets(bool okWithPets) {
  final state = this.state;
  if (state is! TribeFormUnsubmitted) return;

  emit(
    TribeFormUnsubmitted(
      state.form.copyWith(okWithPets: okWithPets),
    ),
  );
}

}
