import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:github/utils/utils.dart';
import 'package:intl/intl.dart';

class CupertinoDateTimePicker extends StatelessWidget {
  const CupertinoDateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
    this.margin,
    this.validate = false,
    this.errorText,
    this.lastDate
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final DateTime lastDate;
  final TimeOfDay selectedTime;
  final EdgeInsets margin;
  final bool validate;
  final String errorText;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate : DateTime(1995),
        firstDate: DateTime(1900),
        lastDate: lastDate != null ? lastDate : DateTime(2100),
        initialDatePickerMode: DatePickerMode.year
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Container(
      margin: margin == null ? EdgeInsets.all(0) : margin,
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _InputDropdown(
              labelText: selectedDate != null ? labelText : "",
              validate: validate,
              errorText: errorText,
              valueText: selectedDate != null ? DateFormat.yMMMd().format(selectedDate) : labelText,
              valueStyle: TextStyle(fontSize: 17,color: selectedDate == null ? Colors.black54 : AppColor.textColor),
              onPressed: () {

                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime:  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                    maxTime:  DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day),
                    currentTime: selectedDate != null ?  selectedDate : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                    onConfirm: (date) {
                      print('confirm $date');
                      selectDate(date);
                    },);

                },
            )
          ),

          //Enable if Time Picker Needed

        ],
      ),
    );
  }
}


class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.validate = false,
    this.errorText,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
  final bool validate;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: validate ? errorText == null ? "Required" : errorText : null,
          labelText: labelText,
          labelStyle: new TextStyle(color: AppColor.subTextColor, fontSize: 15),
          border:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          disabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
        ),
        baseStyle: new TextStyle(color: AppColor.subTextColor, fontSize: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, textScaleFactor: 1, style: new TextStyle(color: AppColor.subTextColor, fontSize: 15),),
            Icon(Icons.event,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
            ),
          ],
        ),
      ),
    );
  }

}
