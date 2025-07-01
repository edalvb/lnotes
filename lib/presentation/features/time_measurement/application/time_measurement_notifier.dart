import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/models/study_type_enum.dart';
import '../../../../domain/usecases/save_study_record_usecase.dart';
import 'time_measurement_state.dart';

part 'time_measurement_notifier.g.dart';

@riverpod
class TimeMeasurementNotifier extends _$TimeMeasurementNotifier {
  late final SaveStudyRecordUseCase _saveStudyRecordUseCase;

  @override
  TimeMeasurementState build() {
    _saveStudyRecordUseCase = getIt<SaveStudyRecordUseCase>();
    return const TimeMeasurementState();
  }

  Future<void> saveRecord({
    required int pageNumber,
    required Duration time,
  }) async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      final valueInSeconds = time.inMilliseconds / 1000.0;
      await _saveStudyRecordUseCase(
        pageNumber: pageNumber,
        type: StudyType.timeMeasurement,
        value: valueInSeconds,
      );
      state = state.copyWith(isSaving: false);
    } catch (e) {
      state = state.copyWith(isSaving: false, error: 'Failed to save record.');
    }
  }
}
