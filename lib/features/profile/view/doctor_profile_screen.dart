import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/app_user.dart';
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
                  decoration:
                      const InputDecoration(labelText: 'Litsenziya raqami'),
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
                            child: CircularProgressIndicator(strokeWidth: 2),
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
                                subtitle: Text(
                                    user.specialty ?? 'Kiritilmagan'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.local_hospital,
                                    color: colorScheme.primary),
                                title: const Text('Shifoxona'),
                                subtitle:
                                    Text(user.hospital ?? 'Kiritilmagan'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.document_scanner,
                                    color: colorScheme.primary),
                                title: const Text('Litsenziya'),
                                subtitle: Text(
                                    user.licenseNumber ?? 'Kiritilmagan'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.timer,
                                    color: colorScheme.primary),
                                title: const Text('Tajriba'),
                                subtitle: Text(user.experienceYears != null
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
                              ListTile(
                                leading: Icon(Icons.settings,
                                    color: colorScheme.primary),
                                title: const Text('Sozlamalar'),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(Icons.help_outline,
                                    color: colorScheme.primary),
                                title: const Text('Yordam'),
                                trailing: const Icon(Icons.chevron_right),
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
