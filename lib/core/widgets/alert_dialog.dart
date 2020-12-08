import 'package:flutter/material.dart';
import 'package:github/core/widgets/button.dart';
import 'package:github/res/styles.dart';


showActionDialog(context, String message, String positive_option, String negative_option, {String title, IconData icon, Function onYesClick, Function onNoClick}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        title: Row(
          children: <Widget>[

            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Icon(icon),

                    new Padding(padding: EdgeInsets.only(left: 10)),

                    Expanded(child: Text(title,textScaleFactor: 1, style: TextStyle(fontSize: 16,color: AppColor.subHeader, fontWeight: FontWeight.bold),)),

                  ],
                ),
              ),
            ),


          ],
        ),
        content: Text(message,textScaleFactor: 1, style: TextStyle(fontSize: 14,color: AppColor.subHeader, ),),
        actions: <Widget>[

          Button.outline(negative_option,
            height: 30,
            width: 100,
            fontSize: 12,
            showIcon: false,
            onPressed: onNoClick,
          ),

          Button(positive_option,
              height: 30,
              width: 100,
              fontSize: 12,
              onPressed: onYesClick
          ),

        ],
      );
    },
  );
}

showInfoDialog(context, String message, {String title, IconData icon, Function onClose, bool noData}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        title: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    icon == null ? Container() : Icon(icon),

                    new Padding(padding: EdgeInsets.only(left: 10)),

                    title == null ? Container() : Expanded(child: Text(title, textScaleFactor: 1, style: TextStyle(fontSize: 16,color: AppColor.subHeader, fontWeight: FontWeight.bold),)),

                  ],
                ),
              ),
            ),

            IconButton(icon: Icon(Icons.close), onPressed: onClose != null ? onClose : (){
              Navigator.pop(context);
            }),
          ],
        ),
        content:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            noData ? Icon(Icons.inbox, color: AppColor.primaryDark, size: 100,) : Container(),

            Text(message == null ? "" : message, textScaleFactor: 1, style: TextStyle(fontSize: 14,color: AppColor.subHeader, ),),

          ],)
      );
    },
  );
}
