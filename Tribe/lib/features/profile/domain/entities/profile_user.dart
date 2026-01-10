

import 'package:tribe/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String pfpUrl;
  final List<String> friends;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.username,
    required this.bio,
    required this.pfpUrl,
    required this.friends,
  });

  //update profile user
  ProfileUser copyWith({String? newBio, String? newPfpurl, List<String>? newFriends}) {
    return ProfileUser(
      uid: uid,
      email: email,
      username: username,
      bio: newBio ?? bio,
      pfpUrl: newPfpurl ?? pfpUrl,
      friends: newFriends ?? friends,
    );
  }

  Map<String, dynamic> toJson() {
    return ({
      '_id': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'pfp': pfpUrl,
      'friends': friends
    });
  }

  factory ProfileUser.fromJson(Map<String, dynamic> jsonUser) {
    return ProfileUser(
      uid: jsonUser['_id'],
      email: jsonUser['email'],
      username: jsonUser['username'],
      bio: jsonUser['bio'] ?? '',
      pfpUrl: jsonUser['pfp'] ?? '',
      friends: List<String>.from(jsonUser['friends'] ??[])
    );
  }
}
