import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/usecases/delete_all_study_records_usecase.dart';
import '../../../../domain/usecases/delete_study_record_usecase.dart';
import '../../../../domain/usecases/get_all_study_records_usecase.dart';
import 'results_viewer_state.dart';

part 'results_viewer_notifier.g.dart';

@riverpod
class ResultsViewerNotifier extends _$ResultsViewerNotifier {
  late final GetAllStudyRecordsUseCase _getAllStudyRecordsUseCase;
  late final DeleteStudyRecordUseCase _deleteStudyRecordUseCase;
  late final DeleteAllStudyRecordsUseCase _deleteAllStudyRecordsUseCase;

  @override
  ResultsViewerState build() {
    _getAllStudyRecordsUseCase = getIt<GetAllStudyRecordsUseCase>();
    _deleteStudyRecordUseCase = getIt<DeleteStudyRecordUseCase>();
    _deleteAllStudyRecordsUseCase = getIt<DeleteAllStudyRecordsUseCase>();
    Future.microtask(() => loadRecords());
    return const ResultsViewerState(isLoading: true);
  }

  Future<void> loadRecords() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final records = await _getAllStudyRecordsUseCase();
      state = state.copyWith(isLoading: false, records: records);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load records.');
    }
  }

  Future<void> deleteRecord(String recordId) async {
    try {
      await _deleteStudyRecordUseCase(recordId);
      final updatedRecords = state.records.where((r) => r.id != recordId).toList();
      state = state.copyWith(records: updatedRecords);
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete record.');
    }
  }

  Future<void> deleteAllRecords() async {
    state = state.copyWith(isLoading: true);
    try {
      await _deleteAllStudyRecordsUseCase();
      await loadRecords();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete all records.');
    }
  }
}
