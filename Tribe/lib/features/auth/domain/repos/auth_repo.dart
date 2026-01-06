import 'package:tribe/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(String username, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}