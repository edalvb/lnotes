import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() => getIt.init();

@module
abstract class SembastModule {
  @preResolve
  @singleton
  Future<Database> get database async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final dbPath = join(appDir.path, 'app.sqlite');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE study_records (
  id TEXT PRIMARY KEY,
  page_label TEXT NOT NULL,
  type TEXT NOT NULL,
  value REAL NOT NULL,
  created_at TEXT NOT NULL
);
''');
        await db.execute('''
CREATE TABLE modulo (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nombre TEXT NOT NULL,
  description TEXT
);
''');
        await db.execute('''
CREATE TABLE ejercicio (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  modulo_id INTEGER NOT NULL,
  nombre TEXT NOT NULL,
  description TEXT,
  config TEXT,
  FOREIGN KEY(modulo_id) REFERENCES modulo(id) ON DELETE CASCADE
);
''');
        await db.insert('modulo', {
          'nombre': 'repetition_counting',
          'description': 'Conteo de repeticiones',
        });
        await db.insert('modulo', {
          'nombre': 'time_measurement',
          'description': 'Medición de tiempo',
        });
      },
    );
    return db;
  }
}
