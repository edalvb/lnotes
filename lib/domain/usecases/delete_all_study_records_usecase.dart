import 'package:injectable/injectable.dart';

import '../repositories/i_study_repository.dart';

@injectable
class DeleteAllStudyRecordsUseCase {
  final IStudyRepository _repository;

  DeleteAllStudyRecordsUseCase(this._repository);

  Future<void> call() {
    return _repository.deleteAllRecords();
  }
}
