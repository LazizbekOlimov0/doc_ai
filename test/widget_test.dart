import 'package:flutter_test/flutter_test.dart';
import 'package:doc_ai/core/models/app_user.dart';
import 'package:doc_ai/features/auth/data/auth_error_mapper.dart';

void main() {
  final testDate = DateTime(2026, 1, 1);

  group('AppUser model', () {
    test('properties are set correctly', () {
      final user = AppUser(
        uid: 'test-id',
        email: 'test@example.com',
        name: 'Test User',
        role: UserRole.patient,
        createdAt: testDate,
      );

      expect(user.uid, 'test-id');
      expect(user.isPatient, true);
      expect(user.isDoctor, false);
    });

    test('copyWith preserves unchanged fields', () {
      final user = AppUser(
        uid: 'uid',
        email: 'a@b.com',
        role: UserRole.doctor,
        createdAt: testDate,
      );

      final updated = user.copyWith(name: 'New Name');
      expect(updated.name, 'New Name');
      expect(updated.email, 'a@b.com');
    });

    test('roleFromString parses correctly', () {
      expect(AppUser.roleFromString('patient'), UserRole.patient);
      expect(AppUser.roleFromString('doctor'), UserRole.doctor);
      expect(AppUser.roleFromString('none'), UserRole.none);
      expect(AppUser.roleFromString('unknown'), UserRole.none);
    });
  });

  group('Auth error mapper', () {
    test('maps known error codes', () {
      expect(
          mapFirebaseAuthError('invalid-email'), 'auth_error.invalid_email');
      expect(
          mapFirebaseAuthError('wrong-password'), 'auth_error.wrong_password');
      expect(mapFirebaseAuthError('user-not-found'),
          'auth_error.user_not_found');
      expect(mapFirebaseAuthError('email-already-in-use'),
          'auth_error.email_already_in_use');
      expect(
          mapFirebaseAuthError('weak-password'), 'auth_error.weak_password');
      expect(mapFirebaseAuthError('too-many-requests'),
          'auth_error.too_many_requests');
      expect(mapFirebaseAuthError('network-request-failed'),
          'auth_error.network_error');
    });

    test('maps unknown codes to unknown_error', () {
      expect(mapFirebaseAuthError('some-unknown-code'),
          'auth_error.unknown_error');
    });
  });
}
