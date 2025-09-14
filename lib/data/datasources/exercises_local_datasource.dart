import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../dtos/exercise_dto.dart';

abstract class IExercisesLocalDatasource {
  Future<List<ExerciseDto>> getByModule(int moduleId);
  Future<ExerciseDto> upsert(ExerciseDto dto);
  Future<void> delete(int id);
}

@LazySingleton(as: IExercisesLocalDatasource)
class ExercisesLocalDatasource implements IExercisesLocalDatasource {
  final Database _db;
  ExercisesLocalDatasource(this._db);

  @override
  Future<List<ExerciseDto>> getByModule(int moduleId) async {
    final rows = await _db.query(
      'ejercicio',
      where: 'modulo_id = ?',
      whereArgs: [moduleId],
      orderBy: 'id ASC',
    );
    return rows.map((e) => ExerciseDto.fromMap(e)).toList();
  }

  @override
  Future<ExerciseDto> upsert(ExerciseDto dto) async {
    final data = dto.toMap();
    final id = await _db.insert(
      'ejercicio',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final row = (await _db.query(
      'ejercicio',
      where: 'id = ?',
      whereArgs: [id],
    )).first;
    return ExerciseDto.fromMap(row);
  }

  @override
  Future<void> delete(int id) async {
    await _db.delete('ejercicio', where: 'id = ?', whereArgs: [id]);
  }
}
