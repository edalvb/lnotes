// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i156;

import '../../data/datasources/exercises_local_datasource.dart' as _i901;
import '../../data/datasources/i_study_local_datasource.dart' as _i429;
import '../../data/datasources/modules_local_datasource.dart' as _i876;
import '../../data/datasources/study_local_datasource_impl.dart' as _i107;
import '../../data/repositories/exercises_repository_impl.dart' as _i530;
import '../../data/repositories/modules_repository_impl.dart' as _i913;
import '../../data/repositories/study_repository_impl.dart' as _i648;
import '../../domain/repositories/i_exercises_repository.dart' as _i857;
import '../../domain/repositories/i_modules_repository.dart' as _i215;
import '../../domain/repositories/i_study_repository.dart' as _i307;
import '../../domain/usecases/delete_all_study_records_usecase.dart' as _i275;
import '../../domain/usecases/delete_study_record_usecase.dart' as _i115;
import '../../domain/usecases/exercises_usecases.dart' as _i777;
import '../../domain/usecases/get_all_study_records_usecase.dart' as _i184;
import '../../domain/usecases/modules_usecases.dart' as _i223;
import '../../domain/usecases/save_study_record_usecase.dart' as _i737;
import '../services/audio_player_service.dart' as _i887;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sembastModule = _$SembastModule();
    await gh.singletonAsync<_i156.Database>(
      () => sembastModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i887.AudioPlayerService>(
      () => _i887.AudioPlayerService(),
    );
    gh.lazySingleton<_i429.IStudyLocalDatasource>(
      () => _i107.StudyLocalDatasourceImpl(gh<_i156.Database>()),
    );
    gh.lazySingleton<_i307.IStudyRepository>(
      () => _i648.StudyRepositoryImpl(gh<_i429.IStudyLocalDatasource>()),
    );
    gh.lazySingleton<_i876.IModulesLocalDatasource>(
      () => _i876.ModulesLocalDatasource(gh<_i156.Database>()),
    );
    gh.lazySingleton<_i215.IModulesRepository>(
      () => _i913.ModulesRepositoryImpl(gh<_i876.IModulesLocalDatasource>()),
    );
    gh.lazySingleton<_i901.IExercisesLocalDatasource>(
      () => _i901.ExercisesLocalDatasource(gh<_i156.Database>()),
    );
    gh.lazySingleton<_i857.IExercisesRepository>(
      () =>
          _i530.ExercisesRepositoryImpl(gh<_i901.IExercisesLocalDatasource>()),
    );
    gh.factory<_i184.GetAllStudyRecordsUseCase>(
      () => _i184.GetAllStudyRecordsUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i737.SaveStudyRecordUseCase>(
      () => _i737.SaveStudyRecordUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i275.DeleteAllStudyRecordsUseCase>(
      () => _i275.DeleteAllStudyRecordsUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i115.DeleteStudyRecordUseCase>(
      () => _i115.DeleteStudyRecordUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i223.GetAllModulesUseCase>(
      () => _i223.GetAllModulesUseCase(gh<_i215.IModulesRepository>()),
    );
    gh.factory<_i223.UpsertModuleUseCase>(
      () => _i223.UpsertModuleUseCase(gh<_i215.IModulesRepository>()),
    );
    gh.factory<_i223.DeleteModuleUseCase>(
      () => _i223.DeleteModuleUseCase(gh<_i215.IModulesRepository>()),
    );
    gh.factory<_i777.GetExercisesByModuleUseCase>(
      () => _i777.GetExercisesByModuleUseCase(gh<_i857.IExercisesRepository>()),
    );
    gh.factory<_i777.UpsertExerciseUseCase>(
      () => _i777.UpsertExerciseUseCase(gh<_i857.IExercisesRepository>()),
    );
    gh.factory<_i777.DeleteExerciseUseCase>(
      () => _i777.DeleteExerciseUseCase(gh<_i857.IExercisesRepository>()),
    );
    return this;
  }
}

class _$SembastModule extends _i464.SembastModule {}
