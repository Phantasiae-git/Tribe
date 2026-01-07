import 'dart:convert';

import 'package:tribe/core/network/api_client.dart';
import 'package:tribe/features/profile/domain/entities/profile_user.dart';
import 'package:tribe/features/profile/domain/repos/profile_repo.dart';

class NodeProfileRepo implements ProfileRepo {

  final ApiClient api = ApiClient();
  ProfileUser? user;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async{
    try{
      final res = await api.get(
        "getUser/$uid",
      );
      final body = jsonDecode(res.body);
      print(body);
      if (res.statusCode == 200) {
        return ProfileUser(uid: uid, email: body['email'], username: body['username'], bio: body['bio'] ?? "", pfpUrl: body['pfp'] ?? "");
      }

      if (res.statusCode == 500) {
        throw Exception(body['error']);
      }
      return null;
    }catch(e){
      return null;
    }
  }

@override
  Future<void> updateProfile(ProfileUser updatedProfile) async {
    try {
      final res = await api.put(
        "updateUser/${updatedProfile.uid}",
              body: {
        "bio": updatedProfile.bio,
        "pfp": updatedProfile.pfpUrl
      },
      );
      final body = jsonDecode(res.body);

      if (res.statusCode == 500) {
        throw Exception(body['error']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}