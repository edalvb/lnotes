import 'package:injectable/injectable.dart';

import '../../domain/models/study_record_model.dart';
import '../../domain/repositories/i_study_repository.dart';
import '../datasources/i_study_local_datasource.dart';

@LazySingleton(as: IStudyRepository)
class StudyRepositoryImpl implements IStudyRepository {
  final IStudyLocalDatasource _localDatasource;

  StudyRepositoryImpl(this._localDatasource);

  @override
  Future<void> saveRecord(StudyRecordModel record) {
    return _localDatasource.saveRecord(record);
  }

  @override
  Future<List<StudyRecordModel>> getAllRecords() {
    return _localDatasource.getAllRecords();
  }

  @override
  Future<void> deleteRecord(String recordId) {
    return _localDatasource.deleteRecord(recordId);
  }

  @override
  Future<void> deleteAllRecords() {
    return _localDatasource.deleteAllRecords();
  }
}
