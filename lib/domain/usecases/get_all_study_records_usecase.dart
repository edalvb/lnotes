import 'package:injectable/injectable.dart';

import '../models/study_record_model.dart';
import '../repositories/i_study_repository.dart';

@injectable
class GetAllStudyRecordsUseCase {
  final IStudyRepository _repository;

  GetAllStudyRecordsUseCase(this._repository);

  Future<List<StudyRecordModel>> call() async {
    final records = await _repository.getAllRecords();
    records.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return records;
  }
}
