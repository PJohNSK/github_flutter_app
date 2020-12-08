import 'package:flutter/material.dart';
import 'package:github/services/multi_lingual_service.dart';
import 'package:github/res/styles.dart';
import 'package:github/utils/constant.dart' as constant;
import 'package:provider/provider.dart';

import '../base_view.dart';

class LanguagePicker extends StatelessWidget {

  List<KeyValueModel> _data = [
    KeyValueModel(key: "English", value: constant.Locale.ENGLISH),
    KeyValueModel(key: "தமிழ்", value: constant.Locale.TAMIL),
  ];

  final viewModel;

  LanguagePicker(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 45,
              width: 80,
              child: DropdownButton<String>(
                isExpanded: true,
                value: viewModel.localeName,
                items: _data
                    .map((data) => DropdownMenuItem<String>(
                          child: Text(
                            data.key,
                            textScaleFactor: 1,
                            style: Theme.of(context).textTheme.body1,
                          ),
                          value: data.value,
                        ))
                    .toList(),
                onChanged: (String value) async {
                  print(value);
                  viewModel.changeLocale(value);
                },
            ));
  }

}

class KeyValueModel {
  String key;
  String value;

  KeyValueModel({this.key, this.value});
}
