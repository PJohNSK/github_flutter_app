import 'package:flutter/material.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/helper/router.dart';
import 'package:github/res/images.dart';
import 'package:github/res/spacing.dart';
import 'package:github/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:github/utils/utils.dart';
import 'package:github/viewmodels/dashboard_view_model.dart';
import 'package:github/viewmodels/tree_view_model.dart';

import '../base_view.dart';

class FilePage extends StatelessWidget {
  String content;
  String fileName;

  FilePage(this.content, this.fileName);

  @override
  Widget build(BuildContext context) {
    return BaseView<TreeViewModel>(
      onModelReady: (viewModel) async {

      },
      builder: (context, viewModel, child) =>
          Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.insert_drive_file, size: 25,),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(fileName, textScaleFactor: 1,
                        style: AppTextStyle.mainHeader,),
                    ],)
              ),
              body: SafeArea(
                      child: ListView(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(5),
                              child:Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: AppStyle.cardShadow,
                                    color: AppColor.white,
                                  ),
                                  child:Expanded(
                                      child: content == null ? Text("", style: AppTextStyle.body, textAlign: TextAlign.left) : Text(content, style: AppTextStyle.body, textAlign: TextAlign.left,
                                      )
                                  )
                              )
                          )
                        ],
                      )

              )

          ),
    );
  }
}