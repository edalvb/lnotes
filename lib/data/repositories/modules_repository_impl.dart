import 'package:injectable/injectable.dart';

import '../../domain/models/module_model.dart';
import '../../domain/repositories/i_modules_repository.dart';
import '../datasources/modules_local_datasource.dart';
import '../dtos/module_dto.dart';

@LazySingleton(as: IModulesRepository)
class ModulesRepositoryImpl implements IModulesRepository {
  final IModulesLocalDatasource _ds;
  ModulesRepositoryImpl(this._ds);

  @override
  Future<List<ModuleModel>> getAll() async {
    final list = await _ds.getAll();
    return list.map((e) => e.toModel()).toList();
  }

  @override
  Future<ModuleModel> upsert(ModuleModel module) async {
    final dto = ModuleDto(
      id: module.id == 0 ? null : module.id,
      nombre: module.nombre,
      description: module.description,
    );
    final saved = await _ds.upsert(dto);
    return saved.toModel();
  }

  @override
  Future<void> delete(int id) => _ds.delete(id);
}
