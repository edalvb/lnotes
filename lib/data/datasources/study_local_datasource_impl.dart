import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../domain/models/study_record_model.dart';
import '../../domain/models/study_type_enum.dart';
import 'i_study_local_datasource.dart';

@LazySingleton(as: IStudyLocalDatasource)
class StudyLocalDatasourceImpl implements IStudyLocalDatasource {
  final Database _database;
  final StoreRef<String, Map<String, dynamic>> _recordStore;

  StudyLocalDatasourceImpl(this._database)
      : _recordStore = stringMapStoreFactory.store('study_records');

  @override
  Future<List<StudyRecordModel>> getAllRecords() async {
    final snapshots = await _recordStore.find(_database);
    return snapshots
        .map((snapshot) => _StudyRecordMapper.fromMap(snapshot.value))
        .toList();
  }

  @override
  Future<void> saveRecord(StudyRecordModel record) async {
    await _recordStore.record(record.id).put(_database, _StudyRecordMapper.toMap(record));
  }
}

class _StudyRecordMapper {
  static Map<String, dynamic> toMap(StudyRecordModel model) {
    return {
      'id': model.id,
      'pageNumber': model.pageNumber,
      'type': model.type.name,
      'value': model.value,
      'createdAt': model.createdAt.toIso8601String(),
    };
  }

  static StudyRecordModel fromMap(Map<String, dynamic> map) {
    return StudyRecordModel(
      id: map['id'] as String,
      pageNumber: map['pageNumber'] as int,
      type: StudyType.values.byName(map['type'] as String),
      value: map['value'] as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
