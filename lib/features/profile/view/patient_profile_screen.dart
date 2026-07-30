import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../gen/strings.g.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key}) : super();

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final authState = context.watch<AuthCubit>().state;
    final appUser = authState.user;

    final cubit = ProfileCubit(repository: AuthRepository());
    if (appUser?.uid != null && appUser!.uid.isNotEmpty) {
      cubit.loadProfile(appUser.uid);
    }

    return BlocProvider<ProfileCubit>.value(
      value: cubit,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          final user = profileState.user ?? appUser;

          return Scaffold(
            appBar: AppBar(
              title: Text(t.profile.title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => context.push(RouteNames.settings),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                final uid = context.read<AuthCubit>().state.user?.uid;
                if (uid != null) context.read<ProfileCubit>().loadProfile(uid);
              },
              child: user == null
                  ? ListView(
                      children: const [
                        SizedBox(
                          height: 400,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
