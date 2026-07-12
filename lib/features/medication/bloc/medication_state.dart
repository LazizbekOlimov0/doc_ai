import 'package:equatable/equatable.dart';
import '../../../models/mock_data.dart';

class MedicationState extends Equatable {
  final List<MockMedication> medications;
  final bool isLoading;

  const MedicationState({
    this.medications = const [],
    this.isLoading = false,
  });

  double get overallAdherence {
    if (medications.isEmpty) return 0;
    final total = medications.fold<double>(0, (sum, m) => sum + m.adherenceRate);
    return total / medications.length;
  }

  MedicationState copyWith({
    List<MockMedication>? medications,
    bool? isLoading,
  }) {
    return MedicationState(
      medications: medications ?? this.medications,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [medications, isLoading];
}
