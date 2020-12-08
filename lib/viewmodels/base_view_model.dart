import 'package:flutter/widgets.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/services/appconfig_service.dart';
import 'package:github/services/multi_lingual_service.dart';
import 'package:github/helper/locator.dart';


class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }


  final MultiLingualService _multiLingualService = locator<MultiLingualService>();
  final AppConfigService _appConfigService = locator<AppConfigService>();

  changeLocale(String locale) async {
    notifyListeners();
  }

  AppConfig get appConfig => _appConfigService.config;

  MultiLingualData get locale => _multiLingualService.data;

  String get localeName => _multiLingualService.locale;

}
