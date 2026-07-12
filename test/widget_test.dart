import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    test('maps known FirebaseAuthException codes', () {
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'invalid-email')),
        contains('email'),
      );
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'wrong-password')),
        contains('parol'),
      );
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'user-not-found')),
        contains('topilmadi'),
      );
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'email-already-in-use')),
        contains('band'),
      );
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'weak-password')),
        contains('oddiy'),
      );
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'too-many-requests')),
        contains('urinish'),
      );
      expect(
        mapFirebaseError(FirebaseAuthException(code: 'network-request-failed')),
        contains('tarmoq'),
      );
    });

    test('maps unknown codes with code in message', () {
      final result =
          mapFirebaseError(FirebaseAuthException(code: 'some-unknown'));
      expect(result, contains('some-unknown'));
    });

    test('maps bare error codes', () {
      expect(
        mapFirebaseAuthError('invalid-email'),
        contains('email'),
      );
      expect(
        mapFirebaseAuthError('wrong-password'),
        contains('parol'),
      );
    });
  });
}
