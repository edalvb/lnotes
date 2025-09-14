import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../domain/models/exercise_model.dart';
import '../../domain/repositories/i_exercises_repository.dart';
import '../datasources/exercises_local_datasource.dart';
import '../dtos/exercise_dto.dart';

@LazySingleton(as: IExercisesRepository)
class ExercisesRepositoryImpl implements IExercisesRepository {
  final IExercisesLocalDatasource _ds;
  ExercisesRepositoryImpl(this._ds);

  @override
  Future<List<ExerciseModel>> getByModule(int moduleId) async {
    final list = await _ds.getByModule(moduleId);
    return list.map((e) => e.toModel()).toList();
  }

  @override
  Future<ExerciseModel> upsert(ExerciseModel exercise) async {
    final dto = ExerciseDto(
      id: exercise.id == 0 ? null : exercise.id,
      moduloId: exercise.moduloId,
      nombre: exercise.nombre,
      description: exercise.description,
      config: exercise.config == null ? null : jsonEncode(exercise.config),
    );
    final saved = await _ds.upsert(dto);
    return saved.toModel();
  }

  @override
  Future<void> delete(int id) => _ds.delete(id);
}
