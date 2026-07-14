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

  Future<void> _showEditDialog(AppUser user) async {
    _loadFromUser(user);

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Profilni tahrirlash'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Ism'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Yosh'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _allergiesController,
                  decoration: const InputDecoration(
                    labelText: 'Allergiyalar (vergul bilan ajrating)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _bloodTypeController,
                  decoration:
                      const InputDecoration(labelText: 'Qon guruhi'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Bekor qilish'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Saqlash'),
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
              title: const Text('Profil'),
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
                    onPressed:
                        isSaving ? null : () => _showEditDialog(user),
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
                              : 'Ism kiritilmagan',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: Column(
                            children: [
                              _ProfileTile(
                                icon: Icons.cake,
                                title: 'Yosh',
                                value: user.age != null
                                    ? '${user.age} yosh'
                                    : 'Kiritilmagan',
                                colorScheme: colorScheme,
                              ),
                              const Divider(height: 1),
                              _ProfileTile(
                                icon: Icons.warning_amber,
                                title: 'Allergiya',
                                value: user.allergies.isNotEmpty
                                    ? user.allergies.join(', ')
                                    : 'Yo\'q',
                                colorScheme: colorScheme,
                              ),
                              const Divider(height: 1),
                              _ProfileTile(
                                icon: Icons.bloodtype,
                                title: 'Qon guruhi',
                                value: user.bloodType ?? 'Noma\'lum',
                                colorScheme: colorScheme,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Column(
                            children: [
                              SwitchListTile(
                                title: const Text('Dark mode'),
                                subtitle:
                                    const Text('Quyuq mavzu yoqish'),
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
                                title: const Text('Til'),
                                subtitle: Text(_localeName(
                                    settingsState.locale)),
                                trailing:
                                    const Icon(Icons.chevron_right),
                                onTap: () => _showLanguagePicker(),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.help_outline,
                                    color: colorScheme.primary),
                                title: const Text('Yordam'),
                                trailing:
                                    const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.info_outline,
                                    color: colorScheme.primary),
                                title: const Text('Ilova haqida'),
                                subtitle: const Text('v1.0.0'),
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
                            onPressed: () {
                              context.read<AuthCubit>().signOut();
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Chiqish'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colorScheme.error,
                              side: BorderSide(
                                  color: colorScheme.error),
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

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tilni tanlang',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading: const Text('🇺🇿'),
                title: const Text('O\'zbekcha'),
                selected: context.watch<SettingsCubit>().state.locale ==
                    AppLocale.uz,
                onTap: () {
                  context.read<SettingsCubit>().setLocale(AppLocale.uz);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Text('🇷🇺'),
                title: const Text('Русский'),
                selected: context.watch<SettingsCubit>().state.locale ==
                    AppLocale.ru,
                onTap: () {
                  context.read<SettingsCubit>().setLocale(AppLocale.ru);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Text('🇬🇧'),
                title: const Text('English'),
                selected: context.watch<SettingsCubit>().state.locale ==
                    AppLocale.en,
                onTap: () {
                  context.read<SettingsCubit>().setLocale(AppLocale.en);
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
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

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final ColorScheme colorScheme;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
