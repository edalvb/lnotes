import '../../domain/models/study_record_model.dart';

abstract class IStudyLocalDatasource {
  Future<void> saveRecord(StudyRecordModel record);
  Future<List<StudyRecordModel>> getAllRecords();
}
