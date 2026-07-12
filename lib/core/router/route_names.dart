class RouteNames {
  RouteNames._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  // Patient
  static const patientShell = '/patient';
  static const patientSymptomInput = '/patient/home';
  static const patientAnalysisResult = '/patient/analysis';
  static const patientMedications = '/patient/medications';
  static const patientDoctorConnect = '/patient/doctor-connect';
  static const patientProfile = '/patient/profile';

  // Doctor
  static const doctorShell = '/doctor';
  static const doctorDashboard = '/doctor/dashboard';
  static const doctorPatientDetail = '/doctor/patient/:id';
  static const doctorReports = '/doctor/reports';
  static const doctorProfile = '/doctor/profile';

  // Booking
  static const booking = '/booking';

  static String doctorPatientDetailPath(String id) => '/doctor/patient/$id';
}
