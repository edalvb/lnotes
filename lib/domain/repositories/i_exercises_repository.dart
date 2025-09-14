import '../models/exercise_model.dart';

abstract class IExercisesRepository {
  Future<List<ExerciseModel>> getByModule(int moduleId);
  Future<ExerciseModel> upsert(ExerciseModel exercise);
  Future<void> delete(int id);
}
