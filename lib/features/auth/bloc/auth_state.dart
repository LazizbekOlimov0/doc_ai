import 'package:equatable/equatable.dart';
import '../../../core/models/app_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;
  final String? errorKey;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorKey,
  });

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && user != null;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    String? errorKey,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorKey: errorKey ?? this.errorKey,
    );
  }

  @override
  List<Object?> get props => [status, user, errorKey];
}
