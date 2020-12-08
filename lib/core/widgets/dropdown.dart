import 'package:flutter/material.dart';
import 'package:github/res/styles.dart';

class DropDown extends StatefulWidget {

  String value;
  String title;
  List<Map<String, dynamic>> items;
  ValueChanged<dynamic> onChanged;

  DropDown({
    @required this.value,
    @required this.items,
    @required this.onChanged,
  });

  DropDown.withTitle(this.title, {
    @required this.value,
    @required this.items,
    @required this.onChanged,
  });

  @override
  _DropDownState createState() => _DropDownState();

}

class _DropDownState extends State<DropDown> {
  List<DropdownMenuItem> dropdownData = new List();

  @override
  void initState() {
    super.initState();

    for(Map<String,dynamic> data in widget.items){
      dropdownData.add(DropdownMenuItem<String>(
        child: Text(data['value']),
        value: data['code'],
      ));
    }
    setState(() {});

    print(dropdownData.length);

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          widget.title == null ? Container() : new Text(
            widget.title, textScaleFactor: 1,
            style: TextStyle(color: AppColor.subTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal),),

          widget.title == null ? Container() : new Padding(
              padding: EdgeInsets.only(top: 0)),

          dropdownData == null ? Container() : Container(
            child: DropdownButton(
              style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
              items: dropdownData,
              onChanged: widget.onChanged,
              isExpanded: true,
              value: widget.value,
            ),
          )

        ],
      ),
    );
  }
}