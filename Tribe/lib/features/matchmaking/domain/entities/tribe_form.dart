import 'package:tribe/features/matchmaking/domain/entities/tags.dart';

class TribeForm {
  final String userID;
  final double minAge;
  final double maxAge;
  final double minMembers;
  final double maxMembers;
  final List<String>?
  locations; //all locations either as object or just the name as string (will depend on API and some other choices)
  final bool okWithPets;
  Map<String, List<Tag>> tags;

  TribeForm({
    required this.userID,
    this.minAge = 18, //change all of these with form settings
    this.maxAge = 99,
    this.minMembers = 3,
    this.maxMembers = 10,
    this.locations,
    this.okWithPets = true,
    Map<String, List<Tag>>? tags,
  }): tags = tags ?? {};

  Map<String, dynamic> toJson() {
    return ({
      'user_id': userID,
      'min_age': minAge,
      'max_age': maxAge,
      'min_members': minMembers,
      'max_members': maxMembers,
      'target_locations': locations,
      'ok_with_pets': okWithPets,
      'tags': tags.map(
        (categoryId, tagList) =>
            MapEntry(categoryId, tagList.map((tag) => tag.toJson()).toList()),
      ),
    });
  }

  TribeForm copyWith({
  double? minAge,
  double? maxAge,
  double? minMembers,
  double? maxMembers,
  List<String>? locations,
  bool? okWithPets,
  Map<String, List<Tag>>? tags,
}) {
  TribeForm newForm = TribeForm(
    userID: userID,
    minAge: minAge ?? this.minAge,
    maxAge: maxAge ?? this.maxAge,
    minMembers: minMembers ?? this.minMembers,
    maxMembers: maxMembers ?? this.maxMembers,
    locations: locations ?? this.locations,
    okWithPets: okWithPets ?? this.okWithPets,
    tags: tags ?? this.tags,
  );
  print(newForm.toJson());
  return newForm;
}

}
