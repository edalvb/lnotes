import 'dart:convert';

import '../../domain/models/exercise_model.dart';

class ExerciseDto {
  final int? id;
  final int? moduloId;
  final String? nombre;
  final String? description;
  final String? config;

  ExerciseDto({
    this.id,
    this.moduloId,
    this.nombre,
    this.description,
    this.config,
  });

  factory ExerciseDto.fromMap(Map<String, dynamic> map) => ExerciseDto(
    id: map['id'] as int?,
    moduloId: map['modulo_id'] as int?,
    nombre: map['nombre'] as String?,
    description: map['description'] as String?,
    config: map['config'] as String?,
  );

  ExerciseModel toModel() => ExerciseModel(
    id: id ?? 0,
    moduloId: moduloId ?? 0,
    nombre: nombre ?? '',
    description: description,
    config: config == null ? null : jsonDecode(config!) as Map<String, dynamic>,
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'modulo_id': moduloId,
    'nombre': nombre,
    'description': description,
    'config': config,
  };
}
