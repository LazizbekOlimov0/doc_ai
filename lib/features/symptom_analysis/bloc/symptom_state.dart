import 'package:equatable/equatable.dart';
import '../../../models/mock_data.dart';

class SymptomState extends Equatable {
  final String inputText;
  final List<String> selectedSymptoms;
  final MockAnalysisResult? lastResult;
  final bool isAnalyzing;

  const SymptomState({
    this.inputText = '',
    this.selectedSymptoms = const [],
    this.lastResult,
    this.isAnalyzing = false,
  });

  SymptomState copyWith({
    String? inputText,
    List<String>? selectedSymptoms,
    MockAnalysisResult? lastResult,
    bool? isAnalyzing,
  }) {
    return SymptomState(
      inputText: inputText ?? this.inputText,
      selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
      lastResult: lastResult ?? this.lastResult,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
    );
  }

  @override
  List<Object?> get props => [inputText, selectedSymptoms, lastResult, isAnalyzing];
}
