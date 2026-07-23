import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/bloc/auth_cubit.dart';
import '../../features/auth/view/splash_screen.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/register_screen.dart';
import '../../features/symptom_analysis/view/symptom_input_screen.dart';
import '../../features/symptom_analysis/view/analysis_result_screen.dart';
import '../../features/medication/view/medications_screen.dart';
import '../../features/doctor_connect/view/doctor_connect_screen.dart';
import '../../features/profile/view/patient_profile_screen.dart';
import '../../features/profile/view/doctor_profile_screen.dart';
import '../../features/doctor_dashboard/view/dashboard_screen.dart';
import '../../features/doctor_dashboard/view/patient_detail_screen.dart';
import '../../features/doctor_dashboard/view/reports_screen.dart';
import '../../features/profile/view/settings_screen.dart';
import '../../features/weather/view/weather_detail_screen.dart';
import '../../features/booking/view/booking_screen.dart';
import '../../core/services/notification_service.dart';
import '../widgets/patient_shell.dart';
import '../widgets/doctor_shell.dart';
import '../models/app_user.dart';
import 'route_names.dart';

GoRouter createRouter(AuthCubit authCubit) {
  return GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    refreshListenable: _AuthListenable(authCubit),
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = authCubit.state;
      final isLoggedIn = authState.isAuthenticated;
      final isAuthRoute = state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.register;
      final isSplash = state.matchedLocation == RouteNames.splash;

      if (isSplash) return null;

      if (!isLoggedIn && !isAuthRoute) return RouteNames.login;
      if (isLoggedIn && isAuthRoute) {
        final role = authState.user?.role;
        if (role == UserRole.patient) {
          return RouteNames.patientSymptomInput;
        }
        if (role == UserRole.doctor) {
          return RouteNames.doctorDashboard;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PatientShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientSymptomInput,
                builder: (context, state) => const SymptomInputScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientAnalysisResult,
                builder: (context, state) => const AnalysisResultScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientMedications,
                builder: (context, state) => const MedicationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientDoctorConnect,
                builder: (context, state) => const DoctorConnectScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientProfile,
                builder: (context, state) => const PatientProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DoctorShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorDashboard,
                builder: (context, state) => const DoctorDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorReports,
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorProfile,
                builder: (context, state) => const DoctorProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.doctorPatientDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DoctorPatientDetailScreen(patientId: id);
        },
      ),
      GoRoute(
        path: RouteNames.weatherDetail,
        builder: (context, state) => const WeatherDetailScreen(),
      ),
      GoRoute(
        path: RouteNames.booking,
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}

class _AuthListenable extends ChangeNotifier {
  _AuthListenable(AuthCubit cubit) {
    cubit.stream.listen((_) => notifyListeners());
  }
}
