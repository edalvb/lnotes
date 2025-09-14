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
import 'package:sqflite/sqflite.dart' as _i779;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as _i342;

import '../../data/datasources/exercises_local_datasource.dart' as _i630;
import '../../data/datasources/i_study_local_datasource.dart' as _i429;
import '../../data/datasources/modules_local_datasource.dart' as _i229;
import '../../data/datasources/study_local_datasource_impl.dart' as _i107;
import '../../data/repositories/exercises_repository_impl.dart' as _i303;
import '../../data/repositories/modules_repository_impl.dart' as _i801;
import '../../data/repositories/study_repository_impl.dart' as _i648;
import '../../domain/repositories/i_exercises_repository.dart' as _i682;
import '../../domain/repositories/i_modules_repository.dart' as _i547;
import '../../domain/repositories/i_study_repository.dart' as _i307;
import '../../domain/usecases/delete_all_study_records_usecase.dart' as _i275;
import '../../domain/usecases/delete_study_record_usecase.dart' as _i115;
import '../../domain/usecases/exercises_usecases.dart' as _i835;
import '../../domain/usecases/get_all_study_records_usecase.dart' as _i184;
import '../../domain/usecases/modules_usecases.dart' as _i1015;
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
    await gh.singletonAsync<_i342.Database>(
      () => sembastModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i887.AudioPlayerService>(
      () => _i887.AudioPlayerService(),
    );
    gh.lazySingleton<_i229.IModulesLocalDatasource>(
      () => _i229.ModulesLocalDatasource(gh<_i779.Database>()),
    );
    gh.lazySingleton<_i630.IExercisesLocalDatasource>(
      () => _i630.ExercisesLocalDatasource(gh<_i779.Database>()),
    );
    gh.lazySingleton<_i429.IStudyLocalDatasource>(
      () => _i107.StudyLocalDatasourceImpl(gh<_i779.Database>()),
    );
    gh.lazySingleton<_i547.IModulesRepository>(
      () => _i801.ModulesRepositoryImpl(gh<_i229.IModulesLocalDatasource>()),
    );
    gh.lazySingleton<_i307.IStudyRepository>(
      () => _i648.StudyRepositoryImpl(gh<_i429.IStudyLocalDatasource>()),
    );
    gh.factory<_i1015.GetAllModulesUseCase>(
      () => _i1015.GetAllModulesUseCase(gh<_i547.IModulesRepository>()),
    );
    gh.factory<_i1015.UpsertModuleUseCase>(
      () => _i1015.UpsertModuleUseCase(gh<_i547.IModulesRepository>()),
    );
    gh.factory<_i1015.DeleteModuleUseCase>(
      () => _i1015.DeleteModuleUseCase(gh<_i547.IModulesRepository>()),
    );
    gh.lazySingleton<_i682.IExercisesRepository>(
      () =>
          _i303.ExercisesRepositoryImpl(gh<_i630.IExercisesLocalDatasource>()),
    );
    gh.factory<_i275.DeleteAllStudyRecordsUseCase>(
      () => _i275.DeleteAllStudyRecordsUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i115.DeleteStudyRecordUseCase>(
      () => _i115.DeleteStudyRecordUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i184.GetAllStudyRecordsUseCase>(
      () => _i184.GetAllStudyRecordsUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i737.SaveStudyRecordUseCase>(
      () => _i737.SaveStudyRecordUseCase(gh<_i307.IStudyRepository>()),
    );
    gh.factory<_i835.GetExercisesByModuleUseCase>(
      () => _i835.GetExercisesByModuleUseCase(gh<_i682.IExercisesRepository>()),
    );
    gh.factory<_i835.UpsertExerciseUseCase>(
      () => _i835.UpsertExerciseUseCase(gh<_i682.IExercisesRepository>()),
    );
    gh.factory<_i835.DeleteExerciseUseCase>(
      () => _i835.DeleteExerciseUseCase(gh<_i682.IExercisesRepository>()),
    );
    gh.factory<_i835.SeedExercisesForModuleUseCase>(
      () =>
          _i835.SeedExercisesForModuleUseCase(gh<_i682.IExercisesRepository>()),
    );
    return this;
  }
}

class _$SembastModule extends _i464.SembastModule {}
