import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/models/app_user.dart';
import '../../../gen/strings.g.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.patient;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty) return;
    if (password.length < 6) {
      final t = Translations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.auth.password_too_short)),
      );
      return;
    }

    context.read<AuthCubit>().signUp(
          email: email,
          password: password,
          role: _selectedRole,
          name: name,
        );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (prev, curr) =>
          curr.status == AuthStatus.error && curr.errorKey != null,
      listener: (context, state) {
        final cubit = context.read<AuthCubit>();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorKey!),
              backgroundColor: colorScheme.error,
              duration: const Duration(seconds: 4),
              action: SnackBarAction(
                label: t.ok,
                textColor: colorScheme.onError,
                onPressed: () => cubit.clearError(),
              ),
            ),
          );
        cubit.clearError();
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return Scaffold(
          appBar: AppBar(title: Text(t.auth.register)),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(t.auth.create_account,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface)),
                  const SizedBox(height: 8),
                  Text(t.auth.register_subtitle,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _nameController,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: t.auth.full_name,
                        prefixIcon: const Icon(Icons.person_outline)),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: t.auth.email,
                        prefixIcon: const Icon(Icons.email_outlined)),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.done,
                    onSubmitted:
                        isLoading ? null : (_) => _handleRegister(),
                    decoration: InputDecoration(
                      labelText: t.auth.password,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(t.auth.your_role,
                      style: textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _RoleCard(
                          icon: Icons.person,
                          title: t.auth.patient,
                          subtitle: t.auth.patient_desc,
                          isSelected: _selectedRole == UserRole.patient,
                          onTap: isLoading
                              ? null
                              : () => setState(() =>
                                  _selectedRole = UserRole.patient),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _RoleCard(
                          icon: Icons.medical_information,
                          title: t.auth.doctor_role,
                          subtitle: t.auth.doctor_desc,
                          isSelected: _selectedRole == UserRole.doctor,
                          onTap: isLoading
                              ? null
                              : () => setState(() =>
                                  _selectedRole = UserRole.doctor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: isLoading ? null : _handleRegister,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : Text(t.auth.register),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () => context.go(RouteNames.login),
                    child: Text(t.auth.has_account),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                size: 40,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface)),
            const SizedBox(height: 4),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12, color: colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
