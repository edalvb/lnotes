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
import 'package:sembast/sembast.dart' as _i310;
import 'package:sembast/sembast_io.dart' as _i156;

import '../../data/datasources/i_study_local_datasource.dart' as _i429;
import '../../data/datasources/study_local_datasource_impl.dart' as _i107;
import '../../data/repositories/study_repository_impl.dart' as _i648;
import '../../domain/repositories/i_study_repository.dart' as _i307;
import '../../domain/usecases/delete_all_study_records_usecase.dart' as _i275;
import '../../domain/usecases/delete_study_record_usecase.dart' as _i115;
import '../../domain/usecases/get_all_study_records_usecase.dart' as _i184;
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
      () => _i107.StudyLocalDatasourceImpl(gh<_i310.Database>()),
    );
    gh.lazySingleton<_i307.IStudyRepository>(
      () => _i648.StudyRepositoryImpl(gh<_i429.IStudyLocalDatasource>()),
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
    return this;
  }
}

class _$SembastModule extends _i464.SembastModule {}
