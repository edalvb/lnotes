import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

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
    final dbPath = join(appDir.path, 'app.db');
    return await databaseFactoryIo.openDatabase(dbPath);
  }
}
