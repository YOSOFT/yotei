import 'package:get_it/get_it.dart';
import 'package:laplanche/data/app_database.dart';

GetIt locator = GetIt.instance;

void setupGetIt() {
  locator.registerSingleton(AppDatabase());
}
