import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/auth_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _repository;
  StreamSubscription? _userSubscription;

  ProfileCubit({required AuthRepository repository})
      : _repository = repository,
        super(const ProfileState());

  void loadProfile(String uid) {
    _userSubscription?.cancel();
    emit(state.copyWith(isLoading: true));

    _userSubscription = _repository.watchUserProfile(uid).listen(
      (user) {
        if (user != null) {
          emit(state.copyWith(user: user, isLoading: false));
        } else {
          emit(state.copyWith(isLoading: false));
        }
      },
      onError: (_) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> updateProfile({
    required String uid,
    String? name,
    int? age,
    List<String>? allergies,
    String? bloodType,
    String? specialty,
    String? licenseNumber,
    String? hospital,
    int? experienceYears,
  }) async {
    emit(state.copyWith(isSaving: true));
    try {
      await _repository.updateUserProfile(
        uid: uid,
        name: name,
        age: age,
        allergies: allergies,
        bloodType: bloodType,
        specialty: specialty,
        licenseNumber: licenseNumber,
        hospital: hospital,
        experienceYears: experienceYears,
      );
      emit(state.copyWith(isSaving: false));
    } catch (e) {
      emit(state.copyWith(isSaving: false, errorKey: 'auth_error.unknown_error'));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
