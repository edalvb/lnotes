import 'package:injectable/injectable.dart';

import '../models/exercise_model.dart';
import '../repositories/i_exercises_repository.dart';

@injectable
class GetExercisesByModuleUseCase {
  final IExercisesRepository _repo;
  GetExercisesByModuleUseCase(this._repo);
  Future<List<ExerciseModel>> call(int moduleId) => _repo.getByModule(moduleId);
}

@injectable
class UpsertExerciseUseCase {
  final IExercisesRepository _repo;
  UpsertExerciseUseCase(this._repo);
  Future<ExerciseModel> call(ExerciseModel exercise) => _repo.upsert(exercise);
}

@injectable
class DeleteExerciseUseCase {
  final IExercisesRepository _repo;
  DeleteExerciseUseCase(this._repo);
  Future<void> call(int id) => _repo.delete(id);
}
