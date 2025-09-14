import 'package:flutter/foundation.dart';

import 'study_type_enum.dart';

@immutable
class StudyRecordModel {
  final String id;
  final String pageLabel;
  final StudyType type;
  final double value;
  final DateTime createdAt;

  const StudyRecordModel({
    required this.id,
    required this.pageLabel,
    required this.type,
    required this.value,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudyRecordModel &&
        other.id == id &&
        other.pageLabel == pageLabel &&
        other.type == type &&
        other.value == value &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pageLabel.hashCode ^
        type.hashCode ^
        value.hashCode ^
        createdAt.hashCode;
  }
}
