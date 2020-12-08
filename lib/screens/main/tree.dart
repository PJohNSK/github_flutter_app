import 'package:flutter/material.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/helper/router.dart';
import 'package:github/res/images.dart';
import 'package:github/res/spacing.dart';
import 'package:github/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:github/utils/utils.dart';
import 'package:github/viewmodels/tree_view_model.dart';

import '../base_view.dart';

class TreePage extends StatelessWidget {
  String repo;
  String branch;

  TreePage(this.repo, this.branch);

  @override
  Widget build(BuildContext context) {
    return BaseView<TreeViewModel>(
      onModelReady: (viewModel) async {
        viewModel.getTree(repo, branch, branch, false, 0);
      },
      builder: (context, viewModel, child) =>
          Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Image.asset(Images.repo, repeat: ImageRepeat.noRepeat, width: 25, height: 25,),
                    Padding(padding: EdgeInsets.only(left: 10)),
                  Text(repo, textScaleFactor: 1,
                    style: AppTextStyle.mainHeader,),
                ],)
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Map<String, Object> stringParams = {"repo": repo, "branch":branch};
                  Navigator.pushNamed(context, Routes.history, arguments: stringParams);
                },
                child: Icon(Icons.history, color: AppColor.white,),
                backgroundColor: AppColor.primaryDark,
              ),
              body: SafeArea(
                child: viewModel.state == ViewState.Busy ? LoadingWidget("") : Container(
                    padding: EdgeInsets.all(5),
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: AppStyle.cardShadow,
                        color: AppColor.white,
                      ),
                      child:Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                            height: 75,
                            child:
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: viewModel.history.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: AppStyle.mildCardShadow,
                                        color: AppColor.primary,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: _buildBreadCrums(viewModel.historyTitle[index], onPressed: (){
                                      viewModel.getTree(repo, viewModel.history[index], viewModel.historyTitle[index], true, index);
                                    })
                                  );
                                }
                            ),),

                            Expanded(
                              child:
                                ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: viewModel.treeView.tree.length,
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.all(10),
                                    itemBuilder: (contexts, index){
                                      return Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            boxShadow: AppStyle.mildCardShadow,
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: _buildCardItem(viewModel.treeView.tree[index].path, subText: viewModel.treeView.tree[index].type, isTree: viewModel.treeView.tree[index].type == "tree"? true: false   , onPressed: () async {
                                          viewModel.treeView.tree[index].type != "tree"? viewModel.fileDownload(viewModel.treeView.tree[index].path ,repo, context): viewModel.getTree(repo, viewModel.treeView.tree[index].sha, viewModel.treeView.tree[index].path.toUpperCase(), false,0);
                                        }),
                                      );
                                    }
                                ),
                            )
                      ],)
                    )

                ),
              )

          ),
    );
  }
  Widget _buildCardItem(String text, {String subText = '', Function onPressed, bool isTree = false}){
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isTree ? Icon(Icons.folder_open) : Icon(Icons.insert_drive_file),
            Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, textScaleFactor: 1, style: AppTextStyle.body,),

                    Text(subText, textScaleFactor: 1, style: AppTextStyle.normal,),
                  ],),
                ),
            Padding(padding: EdgeInsets.only(left: 10)),

            isTree ? Icon(Icons.navigate_next): Icon(Icons.remove_red_eye, color: AppColor.primaryDark,),

          ],
        ),
      ),
    );
  }

  Widget _buildBreadCrums(String text, { Function onPressed}){
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text, textScaleFactor: 1, style: AppTextStyle.underline,),

                ],),
            Padding(padding: EdgeInsets.only(left: 5)),

            Icon(Icons.navigate_next, color: AppColor.primaryDark,)

          ],
        ),
      ),
    );
  }
}