import 'package:flutter/material.dart';
import 'package:github/res/styles.dart';

class Button extends StatefulWidget {

  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color color;
  final double fontSize;
  final Color fontColor;
  final bool isLoading;
  final bool isOutLine;
  final bool showIcon;
  final IconData icons;


  final VoidCallback onPressed;

  Button(this.text, {this.textStyle, this.width, this.height, this.color,
      this.fontSize, this.fontColor, this.onPressed, this.isLoading = false,this.isOutLine=false,this.showIcon=false, this.icons = Icons.add});

  Button.outline(this.text, {this.textStyle, this.width, this.height, this.color,
      this.fontSize, this.fontColor, this.onPressed, this.isLoading = false,this.isOutLine=true,this.showIcon=true, this.icons = Icons.add});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: widget.width == null ? 160 : widget.width,
      height: widget.height == null ? 45 : widget.height,
      child: !widget.isOutLine ? 
      new RaisedButton(
        elevation: 5,
        onPressed: widget.onPressed,
        color: widget.color == null ? Theme.of(context).buttonColor : widget.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            widget.isLoading ? Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Container(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2,),),
            ) : Container(),

            widget.showIcon ? Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: Icon(widget.icons, color: AppColor.white,)
            ) : Container(),

            new Text(widget.text, textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: widget.textStyle == null ?
                  TextStyle(color: widget.fontColor == null ? AppColor.white : widget.fontColor,
                    letterSpacing: 0.8,
                    fontSize: widget.fontSize == null ? 16 : widget.fontSize, fontWeight: FontWeight.bold) : widget.textStyle),

          ],
        ),):
        new OutlineButton(onPressed: widget.onPressed,
        highlightElevation: 0,
        color: widget.color == null ? Theme.of(context).buttonColor : widget.color,
        borderSide: BorderSide(color: Theme.of(context).buttonColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            widget.isLoading ? Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Container(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2,),),
            ) : Container(),

            widget.showIcon ? Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Icon(widget.icons, color: AppColor.primaryDark,)
            ) : Container(),

            new Text(widget.text, textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: widget.textStyle == null ?
                  TextStyle(color: widget.fontColor == null ? Theme.of(context).buttonColor : widget.fontColor,
                    fontSize: widget.fontSize == null ? 16 : widget.fontSize, fontWeight: FontWeight.bold) : widget.textStyle),

          ],
        ),)
        ,
    );
  }
}

//