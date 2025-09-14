import 'package:injectable/injectable.dart';

import '../models/study_record_model.dart';
import '../models/study_type_enum.dart';
import '../repositories/i_study_repository.dart';

@injectable
class SaveStudyRecordUseCase {
  final IStudyRepository _repository;

  SaveStudyRecordUseCase(this._repository);

  Future<void> call({
    required String pageLabel,
    required StudyType type,
    required double value,
  }) async {
    final newRecord = StudyRecordModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pageLabel: pageLabel,
      type: type,
      value: value,
      createdAt: DateTime.now(),
    );
    await _repository.saveRecord(newRecord);
  }
}
