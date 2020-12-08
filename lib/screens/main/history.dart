import 'package:flutter/material.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/core/widgets/network_image_loader.dart';
import 'package:github/res/images.dart';
import 'package:github/res/spacing.dart';
import 'package:github/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:github/utils/utils.dart';
import 'package:github/viewmodels/history_view_model.dart';
import 'package:intl/intl.dart';
import '../base_view.dart';

class HistoryPage extends StatelessWidget {
  String repo;
  String branch;

  HistoryPage(this.repo, this.branch);

  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryViewModel>(
      onModelReady: (viewModel) async {
        viewModel.getHistory(repo);
      },
      builder: (context, viewModel, child) =>
          Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Image.asset(Images.branch, repeat: ImageRepeat.noRepeat, width: 25, height: 25,),
                    Padding(padding: EdgeInsets.only(left: 10)),
                  Text(branch + " - Commit", textScaleFactor: 1,
                    style: AppTextStyle.mainHeader,),
                ],)
              ),
              body: SafeArea(
                child:Container(
                    padding: EdgeInsets.all(5),
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: AppStyle.cardShadow,
                        color: AppColor.white,
                      ),
                      child: viewModel.state == ViewState.Busy ? LoadingWidget("") :
                      ListView.builder(
                          itemCount: viewModel.historyList.history.length,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index){
                            return Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  boxShadow: AppStyle.mildCardShadow,
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: _buildCardItem(viewModel.historyList.history[index].commit.committer.name, subText: viewModel.historyList.history[index].commit.message
                                                    ,date: viewModel.historyList.history[index].commit.committer.date, avatarUrl: viewModel.historyList.history[index].committer == null ? '': viewModel.historyList.history[index].committer.avatarUrl),
                            );
                          }
                      ),
                    )

                ),
              )

          ),
    );
  }
  Widget _buildCardItem(String text, {String subText = '', String date = '', String avatarUrl = '', Function onPressed}){
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: NetworkImageLoader(image: avatarUrl, height: 40, width: 40, errorImage: Images.user, isShimmer: false,fit: BoxFit.fitHeight,),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(child:
              Column(
                mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, textScaleFactor: 1, style: AppTextStyle.body,),

                    Text(subText, textScaleFactor: 1, style: AppTextStyle.normal,),

                    Spacing.medium(),

                    Text(DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(date).toLocal()).toString(), textScaleFactor: 1, style: AppTextStyle.caption, textAlign: TextAlign.right,),
                  ],),
                ),
            Padding(padding: EdgeInsets.only(left: 10)),

          ],
        ),
      ),
    );
  }
}