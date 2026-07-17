import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_user.dart';
import '../../../core/settings/settings_cubit.dart';
import '../../../gen/strings.g.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _licenseController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _hospitalController.dispose();
    _licenseController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _loadFromUser(AppUser user) {
    _nameController.text = user.name;
    _specialtyController.text = user.specialty ?? '';
    _hospitalController.text = user.hospital ?? '';
    _licenseController.text = user.licenseNumber ?? '';
    _experienceController.text = user.experienceYears?.toString() ?? '';
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
                  controller: _specialtyController,
                  decoration:
                      InputDecoration(labelText: t.profile.specialty),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _hospitalController,
                  decoration:
                      InputDecoration(labelText: t.profile.hospital),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _licenseController,
                  decoration:
                      InputDecoration(labelText: t.profile.license_hint),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _experienceController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: t.profile.experience_hint),
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
      final experience = int.tryParse(_experienceController.text.trim());

      context.read<ProfileCubit>().updateProfile(
            uid: user.uid,
            name: _nameController.text.trim(),
            specialty: _specialtyController.text.trim(),
            hospital: _hospitalController.text.trim(),
            licenseNumber: _licenseController.text.trim(),
            experienceYears: experience,
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
              title: Text(t.profile.doctor_title),
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
                          child: Icon(Icons.person,
                              size: 48,
                              color: colorScheme.onPrimaryContainer),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.name.isNotEmpty
                              ? user.name
                              : t.profile.name_empty,
                          style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold),
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
                                leading: Icon(Icons.work,
                                    color: colorScheme.primary),
                                title: Text(t.profile.specialty),
                                subtitle: Text(user.specialty ??
                                    t.not_specified),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.local_hospital,
                                    color: colorScheme.primary),
                                title: Text(t.profile.hospital),
                                subtitle: Text(
                                    user.hospital ?? t.not_specified),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.document_scanner,
                                    color: colorScheme.primary),
                                title: Text(t.profile.license),
                                subtitle: Text(user.licenseNumber ??
                                    t.not_specified),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.timer,
                                    color: colorScheme.primary),
                                title: Text(t.profile.experience),
                                subtitle: Text(
                                  user.experienceYears != null
                                      ? '${user.experienceYears}${t.profile.experience_unit}'
                                      : t.not_specified,
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
                                onTap: () => _showLanguagePicker(t),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
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

extension _DoctorProfileI18n on _DoctorProfileScreenState {
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
