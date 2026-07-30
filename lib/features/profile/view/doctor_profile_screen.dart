import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../gen/strings.g.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/data/auth_repository.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key}) : super();

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
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
              title: Text(t.profile.doctor_title),
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
                if (uid != null && uid.isNotEmpty) cubit.loadProfile(uid);
              },
              child: user == null
                  ? ListView(
                      children: const [
                        SizedBox(height: 400, child: Center(child: CircularProgressIndicator())),
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
