import 'package:flutter/foundation.dart';

import '../../../../domain/models/study_record_model.dart';

@immutable
class ResultsViewerState {
  final bool isLoading;
  final List<StudyRecordModel> records;
  final String? error;

  const ResultsViewerState({
    this.isLoading = false,
    this.records = const [],
    this.error,
  });

  ResultsViewerState copyWith({
    bool? isLoading,
    List<StudyRecordModel>? records,
    String? error,
  }) {
    return ResultsViewerState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
      error: error ?? this.error,
    );
  }
}
