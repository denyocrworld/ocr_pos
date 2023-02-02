import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hyper_ui/service/db_service/db_service.dart';
import 'package:hyper_ui/service/main_storage/main_storage.dart';
import 'package:path_provider/path_provider.dart';

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var path = await getTemporaryDirectory();
    Hive.init(path.path);
  }
  mainStorage = await Hive.openBox('mainStorage');
  await DbService.load();
}
