import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:github/core/enums/environment.dart';
import 'package:github/core/models/api_error_response.dart';
import 'package:github/core/models/api_exceptions.dart';
import 'package:github/core/widgets/alert_dialog.dart';
import 'package:github/services/appconfig_service.dart';
import 'package:github/services/multi_lingual_service.dart';
import 'package:github/helper/navigation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/services/preference_service.dart';
import 'package:github/services/secure_storage.dart';
import 'package:github/utils/utils.dart';
import 'package:http/http.dart';

import '../helper/locator.dart';
import '../helper/router.dart';

dynamic getBasicHeader() async {
  Map<String, String> headers = new Map();
  headers['Accept'] = "application/json";
  return headers;
}

class ApiBase {

  final AppConfigService _appConfigService = locator<AppConfigService>();
  final MultiLingualService _multiLingualService = locator<MultiLingualService>();


  var client = new Client();

  // SERIALIZE & ASYNC FUNCTION
  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  Future<Response>  sendAsync(String method, String path, Object body, bool authed,) async {

    SecureStorage secureStorage = SecureStorage();

    var url = Uri.parse(path);
    var requestMessage = Request(method, url);
    Map<String, String> headerParams = {};

    // headerParams["HttpHeaders.contentTypeHeader"] = "application/json";
    // headerParams["UserLanguage"] = _multiLingualService.locale.toUpperCase();

    try {
      if (body != null) {
        if (body == String) {
          headerParams["Content-Type"] = "application/x-www-form-urlencoded";
          requestMessage.body = body as String;
        } else if (body == MultipartRequest) {
        } else {
          headerParams['Accept'] = "application/json";
          headerParams["Content-Type"] = "application/json";
          requestMessage.body = serialize(body);
          debugPrint("Body PARAM" + requestMessage.body);
        }
      }

      if (authed) {
        headerParams['Authorization'] =  "token b1edbb56442f0205a227fea8aced856056e6761d";
      }

      requestMessage.headers.addAll(headerParams);
      print(requestMessage.headers);
      Response response;

      try {

        response=  await Response.fromStream(await client.send(requestMessage));
        debugPrint(path + ":" + response.statusCode.toString());
        debugPrint(path + ":" + response.body.toString());

      } on HttpException catch (e) {
        print("ERROR EXCEPTION ${e}");

        showAlertPopup(_handleConnectionError());
      }

      if (response == null){
        return null;
      }

      if (response.statusCode == 200) {
        return response;
      } else if(response.statusCode == 201){
        return response;
      }else if(response.statusCode == 202){
        return response;
      }
      else if(response.statusCode == 204){
        var context = locator<NavigationHelper>().navigatorKey.currentState.overlay.context;
        showInfoDialog(context,"No data found", title: "Info", icon: Icons.info_outline, noData: true);
        return null;
      }
      else if(response.statusCode == 404){
        var error = await _handleApiError(response, false);
        showAlertPopup(error);
      }
      else if (response.statusCode == 403) {
        showToast("Your session has expired. Please login again");
        SecureStorage secureStorage = SecureStorage();
        secureStorage.clearToken();
        PreferenceService pref = await PreferenceService.init();
        pref.setLoggedIn(false);
        var context = locator<NavigationHelper>().navigatorKey.currentState.overlay.context;
       Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.dashboard));
      }
      else if (response.statusCode >= 400) {
        var error = await _handleApiError(response, false);
        showAlertPopup(error);
      }

      return null;
    } finally {}
  }

  ApiAlert _handleConnectionError() {
    var result = new ApiAlert();
    result.statusCode = 502;
    result.message = "There is a problem connecting to the server.";
    return result;
  }

  Future<ApiAlert> _handleApiError(Response response, bool tokenError) async {
    if ((tokenError && response.statusCode == 400) ||
        response.statusCode == 401)  {
      return null;
    }

    Map<String, Object> responseJObject;
    if (_isJsonResponse(response)) {
      responseJObject = json.decode(response.body);
    }
    return ApiAlert.fromResponse(responseJObject, response.statusCode, tokenError);
  }

  bool _isJsonResponse(Response response) {
    return (response.headers["content-type"]?.contains("json"));
  }

  showAlertPopup(ApiAlert response){

    ApiException apiException = new ApiException(response);

    String title = "Warning";
    IconData icon = Icons.error_outline;



    var context = locator<NavigationHelper>().navigatorKey.currentState.overlay.context;
    showInfoDialog(context,apiException.error.message, title: title, icon: icon, noData: false);
  }

}