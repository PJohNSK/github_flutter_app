import 'package:flutter/cupertino.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/core/models/download.dart';
import 'package:github/core/models/tree.dart';
import 'package:github/helper/locator.dart';
import 'package:github/helper/router.dart';
import 'package:github/services/api.dart';

import 'base_view_model.dart';
import 'dart:convert';

class TreeViewModel extends BaseViewModel {

  final API _api = locator<API>();

  List<String> history = new List();
  List<String> historyTitle = new List();

  TreeView treeView;
  Download download;

  getTree(String repo, String branch, String title, bool isDelete, int index) async {
    setState(ViewState.Busy);
    if(isDelete){
      history.removeRange(index+1, history.length);
      historyTitle.removeRange(index+1, historyTitle.length);
    }else {
      history.add(branch);
      historyTitle.add(title.toUpperCase());
    }
    var result = await _api.getTree(repo, branch);
    treeView = result;
    setState(ViewState.Idle);
    notifyListeners();
  }


  fileDownload(String fileName, String repo, BuildContext context) async {
    setState(ViewState.Busy);
    String url="";
    for(int i =0 ; i<history.length; i++){
      url = url + "/" + historyTitle[i].toLowerCase();
    }
    String content = await _api.readFile(url + "/" + fileName, repo);
    Map<String, Object> stringParams = {"content": content, "fileName":fileName};
    Navigator.pushNamed(context, Routes.file, arguments: stringParams);
    setState(ViewState.Idle);
  }
}