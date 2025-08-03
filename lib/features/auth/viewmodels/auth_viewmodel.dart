import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:anime_lab/features/auth/repositories/auth_repository.dart';
import 'package:anime_lab/features/auth/repositories/auth_repository_impl.dart';
import 'package:anime_lab/features/auth/services/auth_service.dart';
import 'package:anime_lab/features/auth/services/auth_service_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_viewmodel.freezed.dart';

part 'auth_viewmodel.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  ref.keepAlive();
  return AuthRepositoryImpl();
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  ref.keepAlive();
  return AuthServiceImpl(ref.read(authRepositoryProvider));
}

// ---------

@freezed
abstract class AuthViewState with _$AuthViewState {
  const factory AuthViewState({
    User? user,
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    String? error,
  }) = _AuthViewState;
}

// ---------

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthViewState build() {
    return const AuthViewState();
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(authServiceProvider);
      final user = await service.signInWithGoogle();

      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: user != null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signInWithEmail(
    String email,
    String password,
    bool keepLoggedIn,
  ) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(authServiceProvider);
      final user = await service.signInWithEmail(email, password, keepLoggedIn);

      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: user != null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(authServiceProvider);
      final user = await service.signUpWithEmail(email, password);

      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: user != null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(authServiceProvider);
      await service.signOut();

      state = state.copyWith(
        user: null,
        isLoading: false,
        isAuthenticated: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
