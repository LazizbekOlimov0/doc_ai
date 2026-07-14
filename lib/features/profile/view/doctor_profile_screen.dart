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
                  controller: _specialtyController,
                  decoration:
                      const InputDecoration(labelText: 'Mutaxassislik'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _hospitalController,
                  decoration:
                      const InputDecoration(labelText: 'Shifoxona'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _licenseController,
                  decoration: const InputDecoration(
                      labelText: 'Litsenziya raqami'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _experienceController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Tajriba (yil)'),
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
      final experience =
          int.tryParse(_experienceController.text.trim());

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
              title: const Text('Shifokor profili'),
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
                        : () => _showEditDialog(user),
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
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: colorScheme.onPrimaryContainer,
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
                              ListTile(
                                leading: Icon(Icons.work,
                                    color: colorScheme.primary),
                                title: const Text('Mutaxassislik'),
                                subtitle: Text(user.specialty ??
                                    'Kiritilmagan'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.local_hospital,
                                    color: colorScheme.primary),
                                title: const Text('Shifoxona'),
                                subtitle: Text(user.hospital ??
                                    'Kiritilmagan'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.document_scanner,
                                    color: colorScheme.primary),
                                title: const Text('Litsenziya'),
                                subtitle: Text(user.licenseNumber ??
                                    'Kiritilmagan'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.timer,
                                    color: colorScheme.primary),
                                title: const Text('Tajriba'),
                                subtitle: Text(
                                    user.experienceYears != null
                                        ? '${user.experienceYears} yil'
                                        : 'Kiritilmagan'),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
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
