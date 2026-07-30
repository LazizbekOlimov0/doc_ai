import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/doctor_reports_cubit.dart';

class DoctorPatientReportsPage extends StatefulWidget {
  const DoctorPatientReportsPage({super.key});

  @override
  State<DoctorPatientReportsPage> createState() => _DoctorPatientReportsPageState();
}

class _DoctorPatientReportsPageState extends State<DoctorPatientReportsPage> {
  late final DoctorReportsCubit _cubit;
  final Map<String, bool> _expandedPatients = {};

  @override
  void initState() {
    super.initState();
    _cubit = DoctorReportsCubit()..loadReports();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('Bemor hisobotlari')),
        body: RefreshIndicator(
          onRefresh: () async => _cubit.loadReports(),
          child: BlocBuilder<DoctorReportsCubit, DoctorReportsState>(
            builder: (context, state) {
              if (state is DoctorReportsLoading) {
                return ListView(children: const [SizedBox(height: 400, child: Center(child: CircularProgressIndicator()))]);
              }

              if (state is DoctorReportsError) {
                return ListView(children: [SizedBox(height: 400, child: Center(child: Text(state.message)))]);
              }

              if (state is DoctorReportsLoaded) {
                if (state.reportsByPatient.isEmpty) {
                  return ListView(children: const [SizedBox(height: 400, child: Center(child: Text('Hozircha hisobotlar yo\'q')))]);
                }

                final patients = state.reportsByPatient.entries.toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    final entry = patients[index];
                    final patientId = entry.key;
                    final reports = entry.value;
                    final patientName = reports.first.patientName;
                    final patientEmail = reports.first.patientEmail;
                    final isExpanded = _expandedPatients[patientId] ?? false;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: colorScheme.primaryContainer,
                              child: Text(patientName.isNotEmpty ? patientName[0].toUpperCase() : 'P',
                                style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onPrimaryContainer)),
                            ),
                            title: Text(patientName, style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('${reports.length} ta hisobot${patientEmail.isNotEmpty ? ' · $patientEmail' : ''}'),
                            trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                            onTap: () => setState(() => _expandedPatients[patientId] = !isExpanded),
                          ),
                          if (isExpanded)
                            ...reports.map((report) => Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Row(children: [
                                    Icon(Icons.access_time, size: 14, color: colorScheme.onSurfaceVariant),
                                    const SizedBox(width: 4),
                                    Text(_formatDate(report.timestamp), style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
                                  ]),
                                  if (report.patientEmail.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                                      child: Row(children: [
                                        Icon(Icons.email_outlined, size: 13, color: colorScheme.onSurfaceVariant),
                                        const SizedBox(width: 4),
                                        Text(report.patientEmail, style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
                                      ]),
                                    ),
                                  if (report.patientAge != null || report.patientBloodType != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        [if (report.patientAge != null) '${report.patientAge} yosh', if (report.patientBloodType != null) 'Qon: ${report.patientBloodType}'].join(' · '),
                                        style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                                      ),
                                    ),
                                  if (report.patientAllergies.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(children: [
                                        Icon(Icons.warning_amber, size: 13, color: Colors.orange[700]),
                                        const SizedBox(width: 4),
                                        Expanded(child: Text('Allergiya: ${report.patientAllergies.join(", ")}', style: TextStyle(fontSize: 12, color: Colors.orange[700]))),
                                      ]),
                                    ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
                                    child: Text(report.summaryText, style: const TextStyle(fontSize: 14), maxLines: 8, overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            )),
                        ],
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
