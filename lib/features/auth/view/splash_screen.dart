import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/models/app_user.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigate(AuthState authState) {
    if (!mounted) return;
    if (authState.isAuthenticated && authState.user != null) {
      final role = authState.user!.role;
      if (role == UserRole.patient) {
        context.go(RouteNames.patientSymptomInput);
      } else if (role == UserRole.doctor) {
        context.go(RouteNames.doctorDashboard);
      }
    } else if (authState.status != AuthStatus.initial &&
        authState.status != AuthStatus.loading) {
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 2), () => _navigate(state));
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primaryContainer,
              ],
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.medical_services_rounded,
                      size: 56,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'DocAI',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sizning tibbiy yordamchingiz',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          AlwaysStoppedAnimation(colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
