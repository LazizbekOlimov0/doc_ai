import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum UserRole { patient, doctor, none }

class AppUser extends Equatable {
  final String uid;
  final String email;
  final String name;
  final UserRole role;
  final DateTime createdAt;
  final int? age;
  final List<String> allergies;
  final String? bloodType;
  final String? specialty;
  final String? licenseNumber;
  final String? hospital;
  final int? experienceYears;

  final String? linkedDoctorId;

  const AppUser({
    required this.uid,
    required this.email,
    this.name = '',
    required this.role,
    required this.createdAt,
    this.age,
    this.allergies = const [],
    this.bloodType,
    this.specialty,
    this.licenseNumber,
    this.hospital,
    this.experienceYears,
    this.linkedDoctorId,
  });

  bool get isPatient => role == UserRole.patient;
  bool get isDoctor => role == UserRole.doctor;

  AppUser copyWith({
    String? uid,
    String? email,
    String? name,
    UserRole? role,
    DateTime? createdAt,
    int? age,
    List<String>? allergies,
    String? bloodType,
    String? specialty,
    String? licenseNumber,
    String? hospital,
    int? experienceYears,
    String? linkedDoctorId,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      age: age ?? this.age,
      allergies: allergies ?? this.allergies,
      bloodType: bloodType ?? this.bloodType,
      specialty: specialty ?? this.specialty,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      hospital: hospital ?? this.hospital,
      experienceYears: experienceYears ?? this.experienceYears,
      linkedDoctorId: linkedDoctorId ?? this.linkedDoctorId,
    );
  }

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      uid: doc.id,
      email: data['email'] as String? ?? '',
      name: data['name'] as String? ?? '',
      role: roleFromString(data['role'] as String? ?? 'none'),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      age: data['age'] as int?,
      allergies: List<String>.from(data['allergies'] as List? ?? []),
      bloodType: data['bloodType'] as String?,
      specialty: data['specialty'] as String?,
      licenseNumber: data['licenseNumber'] as String?,
      hospital: data['hospital'] as String?,
      experienceYears: data['experienceYears'] as int?,
      linkedDoctorId: data['linkedDoctorId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{
      'email': email,
      'name': name,
      'role': role.name,
      'createdAt': Timestamp.fromDate(createdAt),
      if (age != null) 'age': age,
      if (allergies.isNotEmpty) 'allergies': allergies,
      if (bloodType != null) 'bloodType': bloodType,
      if (specialty != null) 'specialty': specialty,
      if (licenseNumber != null) 'licenseNumber': licenseNumber,
      if (hospital != null) 'hospital': hospital,
      if (experienceYears != null) 'experienceYears': experienceYears,
      if (linkedDoctorId != null) 'linkedDoctorId': linkedDoctorId,
    };
    return data;
  }

  static UserRole roleFromString(String role) {
    switch (role) {
      case 'patient':
        return UserRole.patient;
      case 'doctor':
        return UserRole.doctor;
      default:
        return UserRole.none;
    }
  }

  @override
  List<Object?> get props => [uid, email, name, role, createdAt];
}
