import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/study_record_model.dart';
import '../../domain/models/study_type_enum.dart';
import 'i_study_local_datasource.dart';

@LazySingleton(as: IStudyLocalDatasource)
class StudyLocalDatasourceImpl implements IStudyLocalDatasource {
  final Database _database;

  StudyLocalDatasourceImpl(this._database);

  @override
  Future<List<StudyRecordModel>> getAllRecords() async {
    final rows = await _database.query('study_records', orderBy: 'created_at DESC');
    return rows.map((e) => _StudyRecordMapper.fromMap(e)).toList();
  }

  @override
  Future<void> saveRecord(StudyRecordModel record) async {
    await _database.insert(
      'study_records',
      _StudyRecordMapper.toMap(record),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteRecord(String recordId) async {
    await _database.delete('study_records', where: 'id = ?', whereArgs: [recordId]);
  }

  @override
  Future<void> deleteAllRecords() async {
    await _database.delete('study_records');
  }
}

class _StudyRecordMapper {
  static Map<String, dynamic> toMap(StudyRecordModel model) {
    return {
      'id': model.id,
      'page_label': model.pageLabel,
      'type': model.type.name,
      'value': model.value,
      'created_at': model.createdAt.toIso8601String(),
    };
  }

  static StudyRecordModel fromMap(Map<String, dynamic> map) {
    return StudyRecordModel(
      id: map['id'] as String,
      pageLabel: map['page_label'] as String,
      type: StudyType.values.byName(map['type'] as String),
      value: (map['value'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
