import 'package:flutter/material.dart';

enum SpacingType { Horizontal, Vertical }

class Spacing extends StatelessWidget {

  final double spacing;
  final SpacingType type;

  Spacing._(this.spacing, this.type);

  factory Spacing.thin({SpacingType type = SpacingType.Vertical}){
    return Spacing._(2, type);
  }

  factory Spacing.small({SpacingType type = SpacingType.Vertical}){
    return Spacing._(5, type);
  }

  factory Spacing.medium({SpacingType type = SpacingType.Vertical}){
    return Spacing._(10, type);
  }

  factory Spacing.large({SpacingType type = SpacingType.Vertical}){
    return Spacing._(15, type);
  }

  factory Spacing.xlarge({SpacingType type = SpacingType.Vertical}){
    return Spacing._(20, type);
  }

  factory Spacing.xxlarge({SpacingType type = SpacingType.Vertical}){
    return Spacing._(40, type);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: EdgeInsets.only(top: type == SpacingType.Vertical ? spacing : 0, left: type == SpacingType.Vertical ? 0 : spacing));
  }

}