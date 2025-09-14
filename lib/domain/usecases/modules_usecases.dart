import 'package:injectable/injectable.dart';

import '../models/module_model.dart';
import '../repositories/i_modules_repository.dart';

@injectable
class GetAllModulesUseCase {
  final IModulesRepository _repo;
  GetAllModulesUseCase(this._repo);
  Future<List<ModuleModel>> call() => _repo.getAll();
}

@injectable
class UpsertModuleUseCase {
  final IModulesRepository _repo;
  UpsertModuleUseCase(this._repo);
  Future<ModuleModel> call(ModuleModel module) => _repo.upsert(module);
}

@injectable
class DeleteModuleUseCase {
  final IModulesRepository _repo;
  DeleteModuleUseCase(this._repo);
  Future<void> call(int id) => _repo.delete(id);
}
