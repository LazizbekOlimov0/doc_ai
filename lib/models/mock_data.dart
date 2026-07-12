class MockHospital {
  final String name;
  final String address;
  final double distanceKm;
  final double rating;
  final String imageUrl;

  const MockHospital({
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.rating,
    this.imageUrl = '',
  });
}

class MockMedication {
  final String name;
  final String dosage;
  final int timesPerDay;
  final List<String> times;
  final int durationDays;
  final bool isActive;
  final List<bool> takenToday;

  const MockMedication({
    required this.name,
    required this.dosage,
    required this.timesPerDay,
    required this.times,
    required this.durationDays,
    this.isActive = true,
    this.takenToday = const [],
  });

  double get adherenceRate {
    if (takenToday.isEmpty) return 0;
    return takenToday.where((t) => t).length / takenToday.length;
  }

  MockMedication copyWith({
    List<bool>? takenToday,
  }) {
    return MockMedication(
      name: name,
      dosage: dosage,
      timesPerDay: timesPerDay,
      times: times,
      durationDays: durationDays,
      isActive: isActive,
      takenToday: takenToday ?? this.takenToday,
    );
  }
}

class MockAnalysisResult {
  final String diagnosis;
  final double confidence;
  final List<String> recommendations;
  final List<MockHospital> hospitals;
  final List<MockMedication> medications;
  final String pharmacyName;
  final double pharmacyDistance;
  final DateTime analyzedAt;

  const MockAnalysisResult({
    required this.diagnosis,
    required this.confidence,
    required this.recommendations,
    required this.hospitals,
    required this.medications,
    required this.pharmacyName,
    required this.pharmacyDistance,
    required this.analyzedAt,
  });
}

class MockPatient {
  final String id;
  final String name;
  final int age;
  final String condition;
  final DateTime lastVisit;
  final double adherenceRate;
  final String phoneNumber;
  final List<MockAnalysisResult> history;

  const MockPatient({
    required this.id,
    required this.name,
    required this.age,
    required this.condition,
    required this.lastVisit,
    required this.adherenceRate,
    required this.phoneNumber,
    this.history = const [],
  });
}

class MockDoctor {
  final String id;
  final String name;
  final String specialty;
  final String hospital;
  final int experienceYears;
  final double rating;
  final String phoneNumber;
  final String imageUrl;

  const MockDoctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.experienceYears,
    required this.rating,
    required this.phoneNumber,
    this.imageUrl = '',
  });
}

class MockUser {
  final String id;
  final String name;
  final String email;
  final int? age;
  final String? allergies;
  final String? bloodType;

  const MockUser({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.allergies,
    this.bloodType,
  });
}

// --- Mock Data Instances ---

const List<String> mockSymptoms = [
  'Bosh og\'rig\'i',
  'Isitma',
  'Yo\'tal',
  'Qorin og\'rig\'i',
  'Allergiya',
  'Bel og\'rig\'i',
  'Tomoq og\'rig\'i',
  'Ko\'ngil aynishi',
  'Charchoq',
  'Bosh aylanishi',
];

const List<MockHospital> mockHospitals = [
  MockHospital(
    name: 'Respublika Shoshilinch Tibbiy Yordam',
    address: 'Chilonzor tumani, Kichik halqa yo\'li 2',
    distanceKm: 2.4,
    rating: 4.7,
  ),
  MockHospital(
    name: 'City Med Clinic',
    address: 'Yunusobod tumani, Amir Temur 45',
    distanceKm: 3.1,
    rating: 4.5,
  ),
  MockHospital(
    name: 'MedLife Diagnostika',
    address: 'Mirzo Ulug\'bek tumani, Buyuk Ipak Yo\'li 112',
    distanceKm: 5.8,
    rating: 4.3,
  ),
];

List<MockMedication> mockMedications = [
  MockMedication(
    name: 'Parasetamol',
    dosage: '500 mg',
    timesPerDay: 3,
    times: ['08:00', '14:00', '20:00'],
    durationDays: 5,
    takenToday: [true, false, false],
  ),
  MockMedication(
    name: 'Ibuprofen',
    dosage: '400 mg',
    timesPerDay: 2,
    times: ['09:00', '21:00'],
    durationDays: 7,
    takenToday: [true, false],
  ),
  MockMedication(
    name: 'Amoksitsillin',
    dosage: '250 mg',
    timesPerDay: 3,
    times: ['08:00', '14:00', '20:00'],
    durationDays: 10,
    takenToday: [true, true, false],
  ),
];

final List<MockAnalysisResult> mockAnalysisResults = [
  MockAnalysisResult(
    diagnosis: 'O\'tkir respirator infeksiya (O\'RVI)',
    confidence: 0.85,
    recommendations: [
      'Ko\'proq iliq suyuqlik ichish',
      'Yotoq rejimiga rioya qilish',
      'Harorat 38°C dan oshsa Parasetamol qabul qilish',
    ],
    hospitals: mockHospitals,
    medications: [],
    pharmacyName: 'Dori-Darmon Apteka',
    pharmacyDistance: 0.8,
    analyzedAt: DateTime(2026, 7, 11, 15, 30),
  ),
  MockAnalysisResult(
    diagnosis: 'Allergik rinit',
    confidence: 0.78,
    recommendations: [
      'Allergenlardan saqlanish',
      'Antigistamin preparatlar qabul qilish',
      'Burun yuvish',
    ],
    hospitals: [mockHospitals[1]],
    medications: [],
    pharmacyName: 'Nurafshon Apteka',
    pharmacyDistance: 1.2,
    analyzedAt: DateTime(2026, 7, 10, 10, 15),
  ),
];

final List<MockPatient> mockPatients = [
  MockPatient(
    id: 'p1',
    name: 'Alisher Karimov',
    age: 34,
    condition: 'Gipertoniya',
    lastVisit: DateTime(2026, 7, 10),
    adherenceRate: 0.85,
    phoneNumber: '+998901234567',
  ),
  MockPatient(
    id: 'p2',
    name: 'Madina Toshpulatova',
    age: 28,
    condition: 'Bronxial astma',
    lastVisit: DateTime(2026, 7, 9),
    adherenceRate: 0.62,
    phoneNumber: '+998901112233',
  ),
  MockPatient(
    id: 'p3',
    name: 'Javlon Rahimov',
    age: 45,
    condition: 'Qandli diabet 2-tur',
    lastVisit: DateTime(2026, 7, 8),
    adherenceRate: 0.94,
    phoneNumber: '+998909876543',
  ),
];

const MockDoctor mockDoctor = MockDoctor(
  id: 'd1',
  name: 'Dr. Aziza Mirzayeva',
  specialty: 'Terapevt',
  hospital: 'City Med Clinic',
  experienceYears: 12,
  rating: 4.8,
  phoneNumber: '+998901234567',
);

const MockDoctor mockDoctor2 = MockDoctor(
  id: 'd2',
  name: 'Dr. Botir Sobirov',
  specialty: 'Kardiolog',
  hospital: 'Respublika Kardiologiya Markazi',
  experienceYears: 18,
  rating: 4.9,
  phoneNumber: '+998909998877',
);

const MockUser mockPatientUser = MockUser(
  id: 'u1',
  name: 'Alisher Karimov',
  email: 'alisher@mail.com',
  age: 34,
  allergies: 'Penitsillin, chang',
  bloodType: 'A (II) Rh+',
);

const MockUser mockDoctorUser = MockUser(
  id: 'u2',
  name: 'Dr. Aziza Mirzayeva',
  email: 'aziza.mirzayeva@clinic.uz',
  age: null,
  allergies: null,
  bloodType: null,
);
