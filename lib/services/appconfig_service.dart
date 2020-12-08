
import 'dart:convert';

import 'package:github/core/enums/environment.dart';
import 'package:github/services/multi_lingual_service.dart';
import 'package:github/helper/locator.dart';
import 'package:github/services/preference_service.dart';
import 'package:package_info/package_info.dart';

class AppConfigService {
  AppConfig _appConfig;

  AppConfig get config {
    return _appConfig;
  }

  setConfig(String value){
    _appConfig = AppConfig.fromJson(jsonDecode(value));
  }

}

class AppConfig {
  String baseUrl;

  AppConfig(
      {this.baseUrl,
        });

  AppConfig.fromJson(Map<String, dynamic> json) {
    baseUrl = "";
  }

}
