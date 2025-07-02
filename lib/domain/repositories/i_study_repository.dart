import '../models/study_record_model.dart';

abstract class IStudyRepository {
  Future<void> saveRecord(StudyRecordModel record);
  Future<List<StudyRecordModel>> getAllRecords();
  Future<void> deleteRecord(String recordId);
  Future<void> deleteAllRecords();
}
