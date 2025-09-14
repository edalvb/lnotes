import '../models/module_model.dart';

abstract class IModulesRepository {
  Future<List<ModuleModel>> getAll();
  Future<ModuleModel> upsert(ModuleModel module);
  Future<void> delete(int id);
}
