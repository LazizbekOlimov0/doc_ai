import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/bloc/auth_cubit.dart';
import 'features/symptom_analysis/bloc/symptom_cubit.dart';
import 'features/medication/bloc/medication_cubit.dart';
import 'features/doctor_dashboard/bloc/doctor_dashboard_cubit.dart';
import 'features/booking/bloc/booking_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DocAIApp());
}

class DocAIApp extends StatelessWidget {
  const DocAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit();
    final router = createRouter(authCubit);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider(create: (_) => SymptomCubit()),
        BlocProvider(create: (_) => MedicationCubit()),
        BlocProvider(create: (_) => DoctorDashboardCubit()),
        BlocProvider(create: (_) => BookingCubit()),
      ],
      child: MaterialApp.router(
        title: 'DocAI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: router,
      ),
    );
  }
}
