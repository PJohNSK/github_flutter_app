import 'package:flutter/cupertino.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/helper/router.dart';
import 'package:github/services/api.dart';
import 'package:github/services/preference_service.dart';
import 'package:github/services/secure_storage.dart';
import 'package:github/viewmodels/base_view_model.dart';

import '../helper/locator.dart';


class LoginViewModel extends BaseViewModel {

  final API _api = locator<API>();

  SecureStorage secureStorage = SecureStorage();

  TextEditingController nameController = new TextEditingController();
  FocusNode nameFocus = new FocusNode();
  bool _nameValidate = false;
  bool get nameValidate => _nameValidate;

  set nameValidate(bool value) {
    _nameValidate = value;
    notifyListeners();
  }
  void loginGit(BuildContext context) async {
    setState(ViewState.Busy);
    var result = await _api.getProfile(nameController.text.toString());
    if(result != null){
      await secureStorage.setAuthorization(nameController.text, result.avatarUrl);
      PreferenceService pref = await PreferenceService.init();
      pref.setLoggedIn(true);
      setState(ViewState.Idle);
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    }
    setState(ViewState.Idle);
  }

}