import 'package:flutter/material.dart';
import 'package:github/core/enums/viewstate.dart';
import 'package:github/core/widgets/edit_text.dart';
import 'package:github/res/images.dart';
import 'package:github/res/spacing.dart';
import 'package:github/viewmodels/login_view_model.dart';
import 'package:github/screens/base_view.dart';
import 'package:github/utils/utils.dart';
import 'package:github/core/widgets/button.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BaseView<LoginViewModel>(
      onModelReady: (viewModel) async {
      },
      builder: (context, viewModel, child) => viewModel.state == ViewState.Busy ? LoadingWidget("Authenticating...") : Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              color: AppColor.primaryDark,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 100),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(Images.app_logo, repeat: ImageRepeat.noRepeat, width: 75, height: 75,),


                                    ]
                                  ),
                                ),
                              ],
                            )
                        ),
                        _buildLoginField(viewModel, context),
                      ],
                    ),
                  ),
              ]
          )
        ),
      )
    );
  }

  Widget _buildLoginField(LoginViewModel viewModel, BuildContext context){
    return  Container(
      decoration: BoxDecoration(
          boxShadow: AppStyle.cardShadow,
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: EdgeInsets.only(left: 15, right: 15, top: MediaQuery.of(context).size.height / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          EditText("User Name",
            viewModel.nameController,
            TextInputType.text,
            focusNode: viewModel.nameFocus,
            validate: viewModel.nameValidate,
            errorText: "Invalid Name",
            formSubmitted: (value) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            onChanged: (value){
              viewModel.nameValidate = false;
            },
          ),

          Spacing.large(),
          Button("Continue", onPressed: () async {
            if(viewModel.nameController.text != ""){
              viewModel.loginGit(context);
            }else{
              viewModel.nameValidate = true;
            }
          },),
        ],),
    );
  }

}
