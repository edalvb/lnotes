import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/models/exercise_model.dart';
import '../../../../domain/usecases/exercises_usecases.dart';
import '../../../../domain/usecases/modules_usecases.dart';

final exercisesByModuleProvider =
    FutureProvider.family<List<ExerciseModel>, int>((ref, moduleId) {
      final usecase = getIt<GetExercisesByModuleUseCase>();
      return usecase(moduleId);
    });

final exercisesByModuleNameProvider =
    FutureProvider.family<List<ExerciseModel>, String>((ref, moduleName) async {
      final getModules = getIt<GetAllModulesUseCase>();
      final modules = await getModules();
      final module = modules.firstWhere((m) => m.nombre == moduleName);
      final getExercises = getIt<GetExercisesByModuleUseCase>();
      return getExercises(module.id);
    });

final moduleIdByNameProvider = FutureProvider.family<int, String>((
  ref,
  moduleName,
) async {
  final getModules = getIt<GetAllModulesUseCase>();
  final modules = await getModules();
  final module = modules.firstWhere((m) => m.nombre == moduleName);
  return module.id;
});
