export 'constant.dart';
export '../res/styles.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Toast
showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 12.0
  );

}


// Loading Widget
showLoadingDialog(context, String message){
  return showDialog(context: context, child: LoadingWidget(message, enablePopScope: false,), barrierDismissible: false);
}

class LoadingWidget extends StatelessWidget {

  final String message;
  final bool enablePopScope;

  LoadingWidget(this.message, {this.enablePopScope = true});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(enablePopScope),
        child: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).secondaryHeaderColor),
                    ),
                  ),

                  new Padding(padding: EdgeInsets.only(top: 20)),

                  Text(message, style: TextStyle(fontSize: 20),)

                ],
              )
          ),
        ));
  }

}


// Empty Page Widget
class EmptyPageWidget extends StatelessWidget {

  final String message;
  final String image;

  EmptyPageWidget(this.message, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  new Image.asset(image, width: 100, height: 100,),

                  new Padding(padding: EdgeInsets.only(top: 30)),

                  Text(message, style: TextStyle(fontSize: 20),)

                ],
              )
          ),
        );
  }

}



