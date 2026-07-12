import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<AppUser?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return AppUser.fromFirestore(doc);
      }
    } catch (_) {}
    return null;
  }

  Future<UserRole> getCurrentUserRole() async {
    final user = _auth.currentUser;
    if (user == null) return UserRole.none;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final roleStr = doc.data()?['role'] as String? ?? 'none';
        return AppUser.roleFromString(roleStr);
      }
    } catch (_) {}
    return UserRole.none;
  }

  Future<AppUser> signUp({
    required String email,
    required String password,
    required UserRole role,
    String name = '',
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final appUser = AppUser(
      uid: credential.user!.uid,
      email: email,
      name: name,
      role: role,
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('users')
        .doc(credential.user!.uid)
        .set(appUser.toFirestore());

    return appUser;
  }

  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc =
        await _firestore.collection('users').doc(credential.user!.uid).get();
    if (!doc.exists) {
      final appUser = AppUser(
        uid: credential.user!.uid,
        email: email,
        role: UserRole.patient,
        createdAt: DateTime.now(),
      );
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(appUser.toFirestore());
      return appUser;
    }

    return AppUser.fromFirestore(doc);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> updateUserProfile({
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
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (age != null) updates['age'] = age;
    if (allergies != null) updates['allergies'] = allergies;
    if (bloodType != null) updates['bloodType'] = bloodType;
    if (specialty != null) updates['specialty'] = specialty;
    if (licenseNumber != null) updates['licenseNumber'] = licenseNumber;
    if (hospital != null) updates['hospital'] = hospital;
    if (experienceYears != null) updates['experienceYears'] = experienceYears;

    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(uid).update(updates);
    }
  }

  Stream<AppUser?> watchUserProfile(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (doc.exists) return AppUser.fromFirestore(doc);
      return null;
    });
  }
}
