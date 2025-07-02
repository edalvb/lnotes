import 'package:injectable/injectable.dart';

import '../repositories/i_study_repository.dart';

@injectable
class DeleteStudyRecordUseCase {
  final IStudyRepository _repository;

  DeleteStudyRecordUseCase(this._repository);

  Future<void> call(String recordId) {
    return _repository.deleteRecord(recordId);
  }
}
