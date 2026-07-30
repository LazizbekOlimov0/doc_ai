import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../gen/strings.g.dart';
import '../../../core/models/app_user.dart';
import '../bloc/doctor_dashboard_state.dart';
import '../bloc/doctor_dashboard_state.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorDashboardCubit>().loadPatients();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
      builder: (context, state) {
        final patients = state.filteredPatients;

        return Scaffold(
          appBar: AppBar(
            title: Text(context.t.doctor_dashboard.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () => context.push(RouteNames.booking),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: context.t.doctor_dashboard.search,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () =>
                                context.read<DoctorDashboardCubit>().search(''),
                          )
                        : null,
                  ),
                  onChanged: (q) =>
                      context.read<DoctorDashboardCubit>().search(q),
                ),
              ),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<DoctorDashboardCubit>().loadPatients();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 16),
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            final patient = patients[index];
                            return _PatientCard(
                              patient: patient,
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                              onTap: () {
                                context.read<DoctorDashboardCubit>().selectPatient(patient);
                                context.go(
                                  RouteNames.doctorPatientDetailPath(patient.uid),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PatientCard extends StatelessWidget {
  final AppUser patient;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onTap;

  const _PatientCard({
    required this.patient,
    required this.colorScheme,
    required this.textTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ageText = patient.age != null ? '${patient.age} yosh' : '';
    final bloodText = patient.bloodType != null ? 'Qon: ${patient.bloodType}' : '';

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  patient.name.isNotEmpty ? patient.name[0] : '?',
                  style: TextStyle(
                    fontSize: 20,
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
                      patient.name.isEmpty ? 'Ismsiz' : patient.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      patient.email,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (ageText.isNotEmpty || bloodText.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        [ageText, bloodText].where((s) => s.isNotEmpty).join(' · '),
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (patient.allergies.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.warning_amber, size: 14, color: Colors.orange[700]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              patient.allergies.join(', '),
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.orange[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
