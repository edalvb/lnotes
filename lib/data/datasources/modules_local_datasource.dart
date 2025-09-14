import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../dtos/module_dto.dart';

abstract class IModulesLocalDatasource {
  Future<List<ModuleDto>> getAll();
  Future<ModuleDto?> getByName(String name);
  Future<ModuleDto> upsert(ModuleDto dto);
  Future<void> delete(int id);
}

@LazySingleton(as: IModulesLocalDatasource)
class ModulesLocalDatasource implements IModulesLocalDatasource {
  final Database _db;
  ModulesLocalDatasource(this._db);

  @override
  Future<List<ModuleDto>> getAll() async {
    final rows = await _db.query('modulo', orderBy: 'id ASC');
    return rows.map((e) => ModuleDto.fromMap(e)).toList();
  }

  @override
  Future<ModuleDto?> getByName(String name) async {
    final rows = await _db.query(
      'modulo',
      where: 'nombre = ?',
      whereArgs: [name],
    );
    if (rows.isEmpty) return null;
    return ModuleDto.fromMap(rows.first);
  }

  @override
  Future<ModuleDto> upsert(ModuleDto dto) async {
    final data = dto.toMap();
    final id = await _db.insert(
      'modulo',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final row = (await _db.query(
      'modulo',
      where: 'id = ?',
      whereArgs: [id],
    )).first;
    return ModuleDto.fromMap(row);
  }

  @override
  Future<void> delete(int id) async {
    await _db.delete('modulo', where: 'id = ?', whereArgs: [id]);
  }
}
