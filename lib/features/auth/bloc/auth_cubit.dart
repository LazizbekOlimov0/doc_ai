import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_user.dart';
import '../data/auth_repository.dart';
import '../data/auth_error_mapper.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  StreamSubscription? _authSubscription;

  AuthCubit({AuthRepository? repository})
      : _repository = repository ?? AuthRepository(),
        super(const AuthState()) {
    _authSubscription = _repository.authStateChanges().listen(
      (firebaseUser) {
        if (firebaseUser != null) {
          _onUserLoggedIn(firebaseUser.uid);
        } else {
          emit(const AuthState(status: AuthStatus.unauthenticated));
        }
      },
      onError: (error) {
        debugPrint('authStateChanges error: $error');
        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> _onUserLoggedIn(String uid) async {
    try {
      final role = await _repository.getCurrentUserRole();
      if (role == UserRole.none) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
        return;
      }
      final userData = await _repository.getCurrentUserData();
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: userData,
      ));
    } catch (e) {
      debugPrint('_onUserLoggedIn error: $e');
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required UserRole role,
    String name = '',
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorKey: null));
    try {
      final appUser = await _repository.signUp(
        email: email,
        password: password,
        role: role,
        name: name,
      );
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: appUser,
      ));
    } catch (e) {
      debugPrint('signUp error: $e');
      emit(AuthState(
        status: AuthStatus.error,
        errorKey: mapFirebaseError(e),
      ));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorKey: null));
    try {
      final appUser = await _repository.signIn(
        email: email,
        password: password,
      );
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: appUser,
      ));
    } catch (e) {
      debugPrint('signIn error: $e');
      emit(AuthState(
        status: AuthStatus.error,
        errorKey: mapFirebaseError(e),
      ));
    }
  }

  void clearError() {
    if (state.status == AuthStatus.error) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, errorKey: null));
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  Future<void> refreshUser() async {
    final userData = await _repository.getCurrentUserData();
    if (userData != null) {
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: userData,
      ));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
