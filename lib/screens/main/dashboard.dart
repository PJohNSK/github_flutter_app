import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/core/widgets/alert_dialog.dart';
import 'package:github/core/widgets/network_image_loader.dart';
import 'package:github/core/widgets/shimmer_effect.dart';
import 'package:github/helper/router.dart';
import 'package:github/res/images.dart';
import 'package:github/res/spacing.dart';
import 'package:github/services/preference_service.dart';
import 'package:github/services/secure_storage.dart';
import 'package:github/utils/utils.dart';
import 'package:github/viewmodels/dashboard_view_model.dart';

import '../base_view.dart';

class DashboardPage extends StatelessWidget {

  SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {

    return BaseView<DashboardViewModel>(
        onModelReady: (viewModel) async {
          viewModel.getRepos();
        },
        builder: (context, viewModel, child) => viewModel.state == ViewState.Busy ? LoadingWidget("") : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Git", textScaleFactor: 1,
                    style: AppTextStyle.logoblue,),

                  Text("Hub", textScaleFactor: 1,
                    style: AppTextStyle.logogrey,),
                ],),
            ),

            drawer: Drawer(
              child: Container(
                color: AppColor.white,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 15),
                      child : Row(
                        children: <Widget>[
                          Text("Git", textScaleFactor: 1,
                            style: AppTextStyle.logoblue,),

                          Text("Hub", textScaleFactor: 1,
                            style: AppTextStyle.logogrey,),
                        ],),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: AppColor.white,
                      child: Row(children: <Widget>[
                        Spacing.large(type: SpacingType.Horizontal,),
                        ClipOval(
                          child: NetworkImageLoader(image: viewModel.avatarUrl, height: 75, width: 75, errorImage: Images.user, isShimmer: false,fit: BoxFit.fitHeight,),
                        ),

                        Spacing.medium(type: SpacingType.Horizontal,),
                        viewModel.state == ViewState.Busy ? ShimmerEffect() : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(viewModel.name , textScaleFactor: 1, style: AppTextStyle.text,),

                          ],
                        ),
                      ],
                      ),
                    ),
                    _buildListTileItem("LogOut", onPressed: (){
                      showActionDialog(context, "Are you sure to logout ?", "Yes" , "No" , icon: Icons.power_settings_new ,title: "Logout", onYesClick: () async {
                        SecureStorage secureStorage = SecureStorage();
                        secureStorage.clearToken();
                        PreferenceService pref = await PreferenceService.init();
                        pref.setLoggedIn(false);

                        Navigator.pop(context);

                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                          onNoClick: (){
                            Navigator.pop(context);
                          }
                      );
                    }),
                  ],
                ),
              ),
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
                  child:
                  ListView.builder(
                      itemCount: viewModel.repos.length,
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
                          child: _buildCardItem(viewModel.repos[index].name, subText: viewModel.repos[index].description != null ? viewModel.repos[index].description : "", onPressed: () async {
                            Map<String, Object> stringParams = {"repo": viewModel.repos[index].name, "branch":viewModel.repos[index].defaultBranch};
                            Navigator.pushNamed(context, Routes.tree, arguments: stringParams);
                          }),
                        );
                      }
                  ),
                )

              ),
            )
        )

    );
  }

  Widget _buildCardItem(String text, {String subText = '', Function onPressed}){
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(Images.repo, repeat: ImageRepeat.noRepeat, width: 30, height: 30,),

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

            onPressed == null ? Container() : Icon(Icons.navigate_next),

          ],
        ),
      ),
    );
  }

  Widget _buildListTileItem(String title, {bool showDivider = true, Widget trailing, EdgeInsets padding, Function onPressed}){
    return Container(
      color: AppColor.white,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: <Widget>[
            Container(
              padding: padding ?? EdgeInsets.all(25),
              child: Row(

                children: <Widget>[

                  Spacing.large(type: SpacingType.Horizontal,),

                  Expanded(child: Text(title, textScaleFactor: 1, style: AppTextStyle.body,)),


                ],
              ),

            ),

            showDivider ? AppStyle.divider : Container()
          ],
        ),
      ),
    );
  }
}
