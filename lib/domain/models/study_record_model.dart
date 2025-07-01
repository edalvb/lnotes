import 'package:flutter/foundation.dart';

import 'study_type_enum.dart';

@immutable
class StudyRecordModel {
  final String id;
  final int pageNumber;
  final StudyType type;
  final double value;
  final DateTime createdAt;

  const StudyRecordModel({
    required this.id,
    required this.pageNumber,
    required this.type,
    required this.value,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudyRecordModel &&
        other.id == id &&
        other.pageNumber == pageNumber &&
        other.type == type &&
        other.value == value &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pageNumber.hashCode ^
        type.hashCode ^
        value.hashCode ^
        createdAt.hashCode;
  }
}
