import 'package:injectable/injectable.dart';

import '../models/study_record_model.dart';
import '../models/study_type_enum.dart';
import '../repositories/i_study_repository.dart';

@injectable
class SaveStudyRecordUseCase {
  final IStudyRepository _repository;

  SaveStudyRecordUseCase(this._repository);

  Future<void> call({
    required int pageNumber,
    required StudyType type,
    required double value,
  }) async {
    final newRecord = StudyRecordModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pageNumber: pageNumber,
      type: type,
      value: value,
      createdAt: DateTime.now(),
    );
    await _repository.saveRecord(newRecord);
  }
}
