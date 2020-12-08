import 'package:github/core/enums/viewstate.dart';
import 'package:github/core/models/history.dart';
import 'package:github/helper/locator.dart';
import 'package:github/services/api.dart';

import 'base_view_model.dart';
import 'dart:convert';

class HistoryViewModel extends BaseViewModel {

  final API _api = locator<API>();

  HistoryList historyList;

  getHistory(String repo) async {
    setState(ViewState.Busy);
    var result = await _api.getHistory(repo);
    historyList = result;
    setState(ViewState.Idle);
    notifyListeners();
  }

}