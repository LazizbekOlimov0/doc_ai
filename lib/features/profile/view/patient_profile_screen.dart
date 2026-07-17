import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_user.dart';
import '../../../core/settings/settings_cubit.dart';
import '../../../gen/strings.g.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _bloodTypeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _allergiesController.dispose();
    _bloodTypeController.dispose();
    super.dispose();
  }

  void _loadFromUser(AppUser user) {
    _nameController.text = user.name;
    _ageController.text = user.age?.toString() ?? '';
    _allergiesController.text = user.allergies.join(', ');
    _bloodTypeController.text = user.bloodType ?? '';
  }

  Future<void> _showEditDialog(AppUser user, Translations t) async {
    _loadFromUser(user);

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
                const SizedBox(height: 12),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: t.profile.age),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _allergiesController,
                  decoration:
                      InputDecoration(labelText: t.profile.allergies_hint),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _bloodTypeController,
                  decoration:
                      InputDecoration(labelText: t.profile.blood_type),
                ),
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
      final age = int.tryParse(_ageController.text.trim());
      final allergies = _allergiesController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      context.read<ProfileCubit>().updateProfile(
            uid: user.uid,
            name: _nameController.text.trim(),
            age: age,
            allergies: allergies,
            bloodType: _bloodTypeController.text.trim(),
          );

      context.read<AuthCubit>().refreshUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final authState = context.watch<AuthCubit>().state;
    final appUser = authState.user;
    final settingsState = context.watch<SettingsCubit>().state;

    return BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit(repository: AuthRepository())
        ..loadProfile(appUser?.uid ?? ''),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          final user = profileState.user ?? appUser;
          final isSaving = profileState.isSaving;

          return Scaffold(
            appBar: AppBar(
              title: Text(t.profile.title),
              actions: [
                if (user != null)
                  IconButton(
                    icon: isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.edit),
                    onPressed: isSaving
                        ? null
                        : () => _showEditDialog(user, t),
                  ),
              ],
            ),
            body: user == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: colorScheme.primaryContainer,
                          child: Text(
                            user.name.isNotEmpty ? user.name[0] : '?',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.name.isNotEmpty
                              ? user.name
                              : t.profile.name_empty,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(user.email,
                            style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 24),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.cake,
                                    color: colorScheme.primary),
                                title: Text(t.profile.age),
                                trailing: Text(
                                  user.age != null
                                      ? '${user.age}${t.profile.age_unit}'
                                      : t.not_specified,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant),
                                ),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.warning_amber,
                                    color: colorScheme.primary),
                                title: Text(t.profile.allergies),
                                trailing: Text(
                                  user.allergies.isNotEmpty
                                      ? user.allergies.join(', ')
                                      : t.no,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant),
                                ),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.bloodtype,
                                    color: colorScheme.primary),
                                title: Text(t.profile.blood_type),
                                trailing: Text(
                                  user.bloodType ?? t.unknown,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Column(
                            children: [
                              SwitchListTile(
                                title: Text(t.dark_mode),
                                subtitle: Text(t.dark_mode_subtitle),
                                value: settingsState.isDark,
                                onChanged: (_) => context
                                    .read<SettingsCubit>()
                                    .toggleTheme(),
                                secondary: Icon(
                                  settingsState.isDark
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.language,
                                    color: colorScheme.primary),
                                title: Text(t.language),
                                subtitle:
                                    Text(_localeName(settingsState.locale)),
                                trailing:
                                    const Icon(Icons.chevron_right),
                                onTap: () =>
                                    _showLanguagePicker(t),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.help_outline,
                                    color: colorScheme.primary),
                                title: Text(t.help),
                                trailing:
                                    const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.info_outline,
                                    color: colorScheme.primary),
                                title: Text(t.about),
                                subtitle: Text(t.version),
                                trailing:
                                    const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                context.read<AuthCubit>().signOut(),
                            icon: const Icon(Icons.logout),
                            label: Text(t.logout),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colorScheme.error,
                              side: BorderSide(color: colorScheme.error),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

extension _PatientProfileScreenI18n on _PatientProfileScreenState {
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
              _langTile('🇺🇿', 'O\'zbekcha', AppLocale.uz, ctx),
              _langTile('🇷🇺', 'Русский', AppLocale.ru, ctx),
              _langTile('🇬🇧', 'English', AppLocale.en, ctx),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _langTile(String flag, String name, AppLocale locale, BuildContext ctx) {
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
