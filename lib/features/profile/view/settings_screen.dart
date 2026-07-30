import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_user.dart';
import '../../../core/settings/settings_cubit.dart';
import '../../../gen/strings.g.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../bloc/profile_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key}) : super();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _licenseController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _allergiesController.dispose();
    _bloodTypeController.dispose();
    _specialtyController.dispose();
    _hospitalController.dispose();
    _licenseController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _loadPatientFields(AppUser user) {
    _nameController.text = user.name;
    _ageController.text = user.age?.toString() ?? '';
    _allergiesController.text = user.allergies.join(', ');
    _bloodTypeController.text = user.bloodType ?? '';
  }

  void _loadDoctorFields(AppUser user) {
    _nameController.text = user.name;
    _specialtyController.text = user.specialty ?? '';
    _hospitalController.text = user.hospital ?? '';
    _licenseController.text = user.licenseNumber ?? '';
    _experienceController.text = user.experienceYears?.toString() ?? '';
  }

  Future<void> _showEditDialog(AppUser user, Translations t, ProfileCubit cubit) async {
    final isPatient = user.role == UserRole.patient;
    if (isPatient) {
      _loadPatientFields(user);
    } else {
      _loadDoctorFields(user);
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(t.profile.edit),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: t.profile.name),
                ),
                if (isPatient) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: t.profile.age),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _allergiesController,
                    decoration: InputDecoration(labelText: t.profile.allergies_hint),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _bloodTypeController,
                    decoration: InputDecoration(labelText: t.profile.blood_type),
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _specialtyController,
                    decoration: InputDecoration(labelText: t.profile.specialty),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _hospitalController,
                    decoration: InputDecoration(labelText: t.profile.hospital),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _licenseController,
                    decoration: InputDecoration(labelText: t.profile.license_hint),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _experienceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: t.profile.experience_hint),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(t.save),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      final age = isPatient ? int.tryParse(_ageController.text.trim()) : null;
      final allergies = isPatient
          ? _allergiesController.text
              .split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList()
          : null;
      final experience = isPatient ? null : int.tryParse(_experienceController.text.trim());

      cubit.updateProfile(
            uid: user.uid,
            name: _nameController.text.trim(),
            age: age,
            allergies: allergies,
            bloodType: isPatient ? _bloodTypeController.text.trim() : null,
            specialty: isPatient ? null : _specialtyController.text.trim(),
            hospital: isPatient ? null : _hospitalController.text.trim(),
            licenseNumber: isPatient ? null : _licenseController.text.trim(),
            experienceYears: experience,
          );

      context.read<AuthCubit>().refreshUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final settingsState = context.watch<SettingsCubit>().state;
    final user = context.watch<AuthCubit>().state.user;

    final profileCubit = user != null
        ? (ProfileCubit(repository: AuthRepository())..loadProfile(user.uid))
        : null;

    final scaffold = Scaffold(
        appBar: AppBar(
          title: Text(t.settings),
        ),
        body: ListView(
          children: [
            if (user != null && profileCubit != null)
              ListTile(
                leading: Icon(Icons.edit, color: colorScheme.primary),
                title: Text(t.profile.edit),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showEditDialog(user, t, profileCubit!),
              ),
            SwitchListTile(
              title: Text(t.dark_mode),
              subtitle: Text(t.dark_mode_subtitle),
              value: settingsState.isDark,
              onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
              secondary: Icon(
                settingsState.isDark ? Icons.dark_mode : Icons.light_mode,
                color: colorScheme.primary,
              ),
            ),
            ListTile(
              leading: Icon(Icons.language, color: colorScheme.primary),
              title: Text(t.language),
              subtitle: Text(_localeName(settingsState.locale)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showLanguagePicker(t),
            ),
            ListTile(
              leading: Icon(Icons.help_outline, color: colorScheme.primary),
              title: Text(t.help),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: colorScheme.primary),
              title: Text(t.about),
              subtitle: Text(t.version),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: colorScheme.error),
              title: Text(t.logout, style: TextStyle(color: colorScheme.error)),
              onTap: () => _showLogoutConfirmation(t),
            ),
          ],
        ),
      );

    return profileCubit != null
        ? BlocProvider<ProfileCubit>.value(value: profileCubit, child: scaffold)
        : scaffold;
  }

  void _showLanguagePicker(Translations t) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(t.select_language,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              _langTile(ctx, '🇺🇿', 'O\'zbekcha', AppLocale.uz),
              _langTile(ctx, '🇷🇺', 'Русский', AppLocale.ru),
              _langTile(ctx, '🇬🇧', 'English', AppLocale.en),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _langTile(BuildContext ctx, String flag, String name, AppLocale locale) {
    return ListTile(
      leading: Text(flag),
      title: Text(name),
      selected: ctx.watch<SettingsCubit>().state.locale == locale,
      onTap: () {
        ctx.read<SettingsCubit>().setLocale(locale);
        Navigator.pop(ctx);
      },
    );
  }

  Future<void> _showLogoutConfirmation(Translations t) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(t.logout_title),
          content: Text(t.logout_message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error,
              ),
              child: Text(t.logout),
            ),
          ],
        );
      },
    );
    if (confirmed == true && mounted) {
      context.read<AuthCubit>().signOut();
    }
  }

  String _localeName(AppLocale locale) {
    switch (locale) {
      case AppLocale.uz:
        return 'O\'zbekcha';
      case AppLocale.ru:
        return 'Русский';
      case AppLocale.en:
        return 'English';
    }
  }
}
