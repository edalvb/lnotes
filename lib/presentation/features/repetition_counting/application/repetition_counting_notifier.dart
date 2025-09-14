import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/models/study_type_enum.dart';
import '../../../../domain/usecases/save_study_record_usecase.dart';
import 'repetition_counting_state.dart';

part 'repetition_counting_notifier.g.dart';

@riverpod
class RepetitionCountingNotifier extends _$RepetitionCountingNotifier {
  late final SaveStudyRecordUseCase _saveStudyRecordUseCase;

  @override
  RepetitionCountingState build() {
    _saveStudyRecordUseCase = getIt<SaveStudyRecordUseCase>();
    return const RepetitionCountingState();
  }

  Future<bool> saveRecord({
    required String pageLabel,
    required int count,
  }) async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      await _saveStudyRecordUseCase(
        pageLabel: pageLabel,
        type: StudyType.repetitionCount,
        value: count.toDouble(),
      );
      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: 'Failed to save record.');
      return false;
    }
  }
}
