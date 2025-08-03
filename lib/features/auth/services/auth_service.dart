import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<User?> signInWithGoogle();

  Future<User?> signInWithEmail(
    String email,
    String password,
    bool keepLoggedIn,
  );

  Future<User?> signUpWithEmail(String email, String password);

  Future<void> signOut();

  Future<void> setKeepLoggedIn(bool keepLoggedIn);

  Future<bool> shouldLogoutOnRestart();
}
