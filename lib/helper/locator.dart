import 'package:get_it/get_it.dart';
import 'package:github/services/appconfig_service.dart';
import 'package:github/services/multi_lingual_service.dart';
import 'package:github/viewmodels/dashboard_view_model.dart';
import 'package:github/viewmodels/history_view_model.dart';
import 'package:github/viewmodels/login_view_model.dart';
import 'package:github/viewmodels/tree_view_model.dart';
import '../services/api.dart';
import 'navigation_helper.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => API());
  locator.registerLazySingleton(() => NavigationHelper());
  locator.registerLazySingleton(() => AppConfigService());
  locator.registerLazySingleton(() => MultiLingualService());

  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => DashboardViewModel());
  locator.registerFactory(() => TreeViewModel());
  locator.registerFactory(() => HistoryViewModel());
}