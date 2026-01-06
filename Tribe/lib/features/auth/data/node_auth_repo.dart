import 'dart:convert';
import 'package:tribe/core/network/api_client.dart';
import 'package:tribe/features/auth/domain/entities/app_user.dart';
import 'package:tribe/features/auth/domain/repos/auth_repo.dart';

class NodeAuthRepo implements AuthRepo {
  final ApiClient api = ApiClient();

  AppUser?
  currentUser; //temporary storing of the current user before implementing jwt

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      final res = await api.post(
        "login",
        body: {"email": email, "password": password},
      );

      if (res.statusCode == 200) {
        currentUser = AppUser.fromJson(
          jsonDecode(res.body),
        ); //should return uid, email, username
        return currentUser;
      }

      if (res.statusCode == 401) {
        final body = jsonDecode(res.body);
        throw Exception(body['error']);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      final res = await api.post(
        "createUser",
        body: {"username": username, "email": email, "password": password},
      );

      if (res.statusCode == 200) {
        currentUser = AppUser.fromJson(
          jsonDecode(res.body),
        ); //should return uid, email, name
        return currentUser;
      }

      return null;
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    currentUser = null;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    return currentUser;
  }
}
