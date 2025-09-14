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

class SeedExercisesParams {
  final int moduleId;
  final String prefix;
  final int start;
  final int end;
  final bool clearBefore;
  const SeedExercisesParams({
    required this.moduleId,
    this.prefix = '',
    required this.start,
    required this.end,
    this.clearBefore = false,
  });
}

class SeedExercisesResult {
  final int inserted;
  final int skipped;
  final int deleted;
  const SeedExercisesResult({
    required this.inserted,
    required this.skipped,
    required this.deleted,
  });
}

@injectable
class SeedExercisesForModuleUseCase {
  final IExercisesRepository _repo;
  SeedExercisesForModuleUseCase(this._repo);

  Future<SeedExercisesResult> call(SeedExercisesParams p) async {
    final s = p.start <= p.end ? p.start : p.end;
    final e = p.end >= p.start ? p.end : p.start;
    final prefix = p.prefix.trim();
    var deleted = 0;
    var inserted = 0;
    var skipped = 0;

    final existing = await _repo.getByModule(p.moduleId);
    if (p.clearBefore && existing.isNotEmpty) {
      for (final ex in existing) {
        await _repo.delete(ex.id);
      }
      deleted = existing.length;
    }

    final afterClearExisting = p.clearBefore
        ? <String>{}
        : existing.map((e) => e.nombre).toSet();
    for (var i = s; i <= e; i++) {
      final label = '$prefix$i';
      if (afterClearExisting.contains(label)) {
        skipped++;
        continue;
      }
      await _repo.upsert(
        ExerciseModel(id: 0, moduloId: p.moduleId, nombre: label),
      );
      inserted++;
    }

    return SeedExercisesResult(
      inserted: inserted,
      skipped: skipped,
      deleted: deleted,
    );
  }
}
