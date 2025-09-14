import 'package:flutter/foundation.dart';

@immutable
class ExerciseModel {
  final int id;
  final int moduloId;
  final String nombre;
  final String? description;
  final Map<String, dynamic>? config;

  const ExerciseModel({
    required this.id,
    required this.moduloId,
    required this.nombre,
    this.description,
    this.config,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExerciseModel &&
        other.id == id &&
        other.moduloId == moduloId &&
        other.nombre == nombre &&
        other.description == description &&
        mapEquals(other.config, config);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      moduloId.hashCode ^
      nombre.hashCode ^
      description.hashCode ^
      (config?.hashCode ?? 0);
}
