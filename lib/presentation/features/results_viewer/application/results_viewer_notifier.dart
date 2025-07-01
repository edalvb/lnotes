import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/usecases/get_all_study_records_usecase.dart';
import 'results_viewer_state.dart';

part 'results_viewer_notifier.g.dart';

@riverpod
class ResultsViewerNotifier extends _$ResultsViewerNotifier {
  late final GetAllStudyRecordsUseCase _getAllStudyRecordsUseCase;

  @override
  ResultsViewerState build() {
    _getAllStudyRecordsUseCase = getIt<GetAllStudyRecordsUseCase>();
    Future.microtask(() => _loadRecords());
    return const ResultsViewerState(isLoading: true);
  }

  Future<void> _loadRecords() async {
    try {
      final records = await _getAllStudyRecordsUseCase();
      state = state.copyWith(isLoading: false, records: records);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load records.');
    }
  }
}
