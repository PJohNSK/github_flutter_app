import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:github/core/models/download.dart';
import 'package:github/core/models/history.dart';
import 'package:github/core/models/profile.dart';
import 'package:github/core/models/repos.dart';
import 'package:github/core/models/tree.dart';
import 'package:github/services/api_base.dart';
import 'package:github/core/models/login_response.dart';
import 'package:github/services/secure_storage.dart';
import 'package:path_provider/path_provider.dart';

/*
  All Api functionality of the application
 */

class API extends ApiBase {

  SecureStorage secureStorage = SecureStorage();

  Future<String> getDeviceId() async {
    String deviceId;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId;
    }
    return deviceId;
  }

  Future<Profile> getProfile(String name) async {
    final response = await sendAsync("GET", 'https://api.github.com/users/'+ name, null, true);
    return Profile.fromJson(jsonDecode(response.body));
  }

  Future<ReposList> getRepo() async {
    final response = await sendAsync("GET", "https://api.github.com/users/"+ await secureStorage.getName() +"/repos", null, false);
    return ReposList.fromJson(jsonDecode(response.body));
  }

  Future<TreeView> getTree(String repo, String branch) async {
    final response = await sendAsync("GET", "https://api.github.com/repos/"+ await secureStorage.getName() +"/"+ repo +"/git/trees/"+ branch, null, false);
    return TreeView.fromJson(jsonDecode(response.body));
  }

  Future<Download> getFile(String Url) async {
    final response = await sendAsync("GET", Url, null, false);
    return Download.fromJson(jsonDecode(response.body));
  }


  Future<HistoryList> getHistory(String repo) async {
    final response = await sendAsync("GET", "https://api.github.com/repos/"+ await secureStorage.getName() +"/"+ repo +"/commits", null, false);
    return HistoryList.fromJson(jsonDecode(response.body));
  }


  Future<String> readFile(String url, String repo) async {
    try {
      final response = await sendAsync("GET", "https://raw.githubusercontent.com/"+ await secureStorage.getName() +"/"+ repo + url, null, false);
      return response.body.toString();
    }catch(e){
      print(e.toString());
    }
  }
}
