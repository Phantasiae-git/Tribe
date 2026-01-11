import 'dart:convert';

import 'package:tribe/core/network/api_client.dart';
import 'package:tribe/features/profile/domain/entities/profile_user.dart';
import 'package:tribe/features/profile/domain/repos/profile_repo.dart';

class NodeProfileRepo implements ProfileRepo {
  final ApiClient api = ApiClient();
  ProfileUser? user;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final res = await api.get("users/$uid");
      final body = jsonDecode(res.body);
      print(body);
      if (res.statusCode == 200) {
        final friends = List<String>.from(body['friends'] ?? []);

        return ProfileUser(
          uid: uid,
          email: body['email'],
          username: body['username'],
          bio: body['bio'] ?? "",
          pfpUrl: body['pfp'] ?? "",
          friends: friends,
        );
      }

      if (res.statusCode == 500) {
        throw Exception(body['error']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfile) async {
    try {
      final res = await api.put(
        "users/${updatedProfile.uid}",
        body: {"bio": updatedProfile.bio, "pfp": updatedProfile.pfpUrl},
      );
      final body = jsonDecode(res.body);

      if (res.statusCode == 500) {
        throw Exception(body['error']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> toggleFriend(String currentUid, String targetUid) async {
    try {
      final currentRes = await api.get("users/$currentUid");

      final targetRes = await api.get("users/$targetUid");

      if (currentRes.statusCode == 200 && targetRes.statusCode == 200) {
        final currentBody = jsonDecode(currentRes.body);
        final targetBody = jsonDecode(targetRes.body);
        
        final List<String> currentFriends = List<String>.from(currentBody['friends'] ?? []);
      }
    } catch (e) {}
  }
}
