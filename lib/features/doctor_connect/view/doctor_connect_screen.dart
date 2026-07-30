import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../gen/strings.g.dart';
import '../bloc/doctor_connect_cubit.dart';

class DoctorConnectScreen extends StatefulWidget {
  const DoctorConnectScreen({super.key});

  @override
  State<DoctorConnectScreen> createState() => _DoctorConnectScreenState();
}

class _DoctorConnectScreenState extends State<DoctorConnectScreen> {
  late final DoctorConnectCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = DoctorConnectCubit()..loadDoctors();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text(t.doctor_connect.title)),
        body: RefreshIndicator(
          onRefresh: () async => _cubit.loadDoctors(),
          child: BlocBuilder<DoctorConnectCubit, DoctorConnectState>(
          builder: (context, state) {
            if (state is DoctorConnectLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DoctorConnectError) {
              return ListView(
                children: [
                  SizedBox(
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => _cubit.loadDoctors(),
                            child: const Text('Qayta urinish'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is DoctorConnectLoaded) {
              if (state.linkedDoctorId != null) {
                final linkedDoctor = state.doctors
                    .where((d) => d.uid == state.linkedDoctorId)
                    .firstOrNull;

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[700]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              linkedDoctor != null
                                  ? 'Sizning shifokoringiz: ${linkedDoctor.name}'
                                  : 'Shifokor ulangan ✅',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildDoctorList(context, state),
                    ),
                  ],
                );
              }

              return _buildDoctorList(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      ),
    );
  }

  Widget _buildDoctorList(BuildContext context, DoctorConnectLoaded state) {
    if (state.doctors.isEmpty) {
      return ListView(
        children: [
          SizedBox(
            height: 300,
            child: Center(child: Text('Shifokorlar topilmadi')),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.doctors.length,
      itemBuilder: (context, index) {
        final doctor = state.doctors[index];
        final isLinked = doctor.uid == state.linkedDoctorId;
        final colorScheme = Theme.of(context).colorScheme;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Text(
                        doctor.name.isNotEmpty ? doctor.name[0].toUpperCase() : 'D',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (doctor.specialty != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              doctor.specialty!,
                              style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isLinked)
                      Chip(
                        avatar: Icon(Icons.link, size: 16, color: Colors.green[700]),
                        label: const Text('Ulangan', style: TextStyle(fontSize: 12)),
                        backgroundColor: Colors.green[50],
                      )
                    else
                      FilledButton(
                        onPressed: state.isLinking
                            ? null
                            : () => _cubit.linkDoctor(doctor.uid),
                        child: state.isLinking
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Ulash'),
                      ),
                  ],
                ),
                if (doctor.hospital != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.local_hospital, size: 16, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(doctor.hospital!, style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
