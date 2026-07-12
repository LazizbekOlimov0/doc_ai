import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/mock_data.dart';
import 'symptom_state.dart';

class SymptomCubit extends Cubit<SymptomState> {
  SymptomCubit() : super(const SymptomState());

  void updateInput(String text) {
    emit(state.copyWith(inputText: text));
  }

  void toggleSymptom(String symptom) {
    final symptoms = List<String>.from(state.selectedSymptoms);
    if (symptoms.contains(symptom)) {
      symptoms.remove(symptom);
    } else {
      symptoms.add(symptom);
    }
    emit(state.copyWith(selectedSymptoms: symptoms));
  }

  void analyze() {
    if (state.inputText.isEmpty && state.selectedSymptoms.isEmpty) return;

    emit(state.copyWith(isAnalyzing: true));

    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(
        isAnalyzing: false,
        lastResult: mockAnalysisResults.first,
      ));
    });
  }

  void clearResult() {
    emit(state.copyWith(lastResult: null));
  }
}
