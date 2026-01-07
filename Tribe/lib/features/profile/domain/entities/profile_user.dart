import 'dart:convert';

import 'package:tribe/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String pfpUrl;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.username,
    required this.bio,
    required this.pfpUrl,
  });

  //update profile user
  ProfileUser copyWith({String? newBio, String? newPfpurl}) {
    return ProfileUser(
      uid: uid,
      email: email,
      username: username,
      bio: newBio ?? bio,
      pfpUrl: newPfpurl ?? pfpUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return ({
      '_id': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'pfp': pfpUrl,
    });
  }

  factory ProfileUser.fromJson(Map<String, dynamic> jsonUser) {
    return ProfileUser(
      uid: jsonUser['_id'],
      email: jsonUser['email'],
      username: jsonUser['username'],
      bio: jsonUser['bio'] ?? '',
      pfpUrl: jsonUser['pfp'] ?? '',
    );
  }
}
