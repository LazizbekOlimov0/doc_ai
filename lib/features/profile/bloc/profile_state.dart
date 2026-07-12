import 'package:equatable/equatable.dart';
import '../../../core/models/app_user.dart';

class ProfileState extends Equatable {
  final AppUser? user;
  final bool isLoading;
  final bool isSaving;
  final String? errorKey;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.isSaving = false,
    this.errorKey,
  });

  ProfileState copyWith({
    AppUser? user,
    bool? isLoading,
    bool? isSaving,
    String? errorKey,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorKey: errorKey ?? this.errorKey,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, isSaving, errorKey];
}
