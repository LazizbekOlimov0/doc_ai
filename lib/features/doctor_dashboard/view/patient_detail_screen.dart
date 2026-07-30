import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/app_user.dart';
import '../bloc/doctor_dashboard_state.dart';
import '../../../gen/strings.g.dart';

class DoctorPatientDetailScreen extends StatefulWidget {
  final String patientId;

  const DoctorPatientDetailScreen({super.key, required this.patientId});

  @override
  State<DoctorPatientDetailScreen> createState() => _DoctorPatientDetailScreenState();
}

class _DoctorPatientDetailScreenState extends State<DoctorPatientDetailScreen> {
  List<Map<String, dynamic>> _reports = [];
  bool _reportsLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _reportsLoading = true);
    try {
      final doctorId = FirebaseAuth.instance.currentUser?.uid;
      if (doctorId == null) return;

      final docs = await FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .collection('patientReports')
          .where('patientId', isEqualTo: widget.patientId)
          .orderBy('timestamp', descending: true)
          .get();

      _reports = docs.docs.map((d) => d.data()).toList();
    } catch (_) {}
    if (mounted) setState(() => _reportsLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
      builder: (context, state) {
        final patient = state.patients
            .where((p) => p.uid == widget.patientId)
            .firstOrNull;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/doctor/dashboard'),
            ),
            title: Text(patient?.name.isNotEmpty == true ? patient!.name : context.t.doctor_dashboard.patient_not_found),
          ),
          body: patient == null
              ? Center(child: Text(context.t.doctor_dashboard.patient_not_found_desc))
              : RefreshIndicator(
                  onRefresh: _loadReports,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: colorScheme.primaryContainer,
                                child: Text(
                                  patient.name.isNotEmpty ? patient.name[0] : '?',
                                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: colorScheme.onPrimaryContainer),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(patient.name, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              _infoRow(Icons.email_outlined, patient.email, textTheme, colorScheme),
                              if (patient.age != null)
                                _infoRow(Icons.calendar_today, '${patient.age} yosh', textTheme, colorScheme),
                              if (patient.bloodType != null)
                                _infoRow(Icons.bloodtype_outlined, 'Qon guruhi: ${patient.bloodType}', textTheme, colorScheme),
                              if (patient.allergies.isNotEmpty)
                                _infoRow(Icons.warning_amber, 'Allergiya: ${patient.allergies.join(", ")}', textTheme, colorScheme, warning: true),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Hisobotlar',
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      if (_reportsLoading)
                        const Center(child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ))
                      else if (_reports.isEmpty)
                        const Center(child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('Hozircha hisobotlar yo\'q'),
                        ))
                      else
                        ..._reports.map((r) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _formatDate((r['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now()),
                                      style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      r['summaryText'] as String? ?? '',
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String text, TextTheme textTheme, ColorScheme colorScheme, {bool warning = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: warning ? Colors.orange[700] : colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Flexible(child: Text(text, style: textTheme.bodyMedium?.copyWith(color: warning ? Colors.orange[700] : colorScheme.onSurfaceVariant))),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
