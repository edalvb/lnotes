import 'package:flutter/foundation.dart';

@immutable
class TimeMeasurementState {
  final bool isSaving;
  final String? error;

  const TimeMeasurementState({
    this.isSaving = false,
    this.error,
  });

  TimeMeasurementState copyWith({
    bool? isSaving,
    String? error,
  }) {
    return TimeMeasurementState(
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }
}
