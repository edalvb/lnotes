import 'package:flutter/foundation.dart';

@immutable
class RepetitionCountingState {
  final bool isSaving;
  final String? error;

  const RepetitionCountingState({
    this.isSaving = false,
    this.error,
  });

  RepetitionCountingState copyWith({
    bool? isSaving,
    String? error,
  }) {
    return RepetitionCountingState(
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }
}
