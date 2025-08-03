import 'package:anime_lab/features/auth/repositories/auth_repository.dart';
import 'package:anime_lab/features/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository _repository;

  AuthServiceImpl(this._repository);

  @override
  Future<User?> signInWithGoogle() async {
    return await _repository.signInWithGoogle();
  }

  @override
  Future<User?> signInWithEmail(
    String email,
    String password,
    bool keepLoggedIn,
  ) async {
    final user = await _repository.signInWithEmail(email, password);

    if (user != null) {
      await setKeepLoggedIn(keepLoggedIn);
    }

    return user;
  }

  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    return await _repository.signUpWithEmail(email, password);
  }

  @override
  Future<void> signOut() async {
    return await _repository.signOut();
  }

  @override
  Future<void> setKeepLoggedIn(bool keepLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('should_logout_on_restart', !keepLoggedIn);
  }

  @override
  Future<bool> shouldLogoutOnRestart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('should_logout_on_restart') ?? false;
  }
}
