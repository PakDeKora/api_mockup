import 'package:coin_gecko/app/config/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressBar extends StatelessWidget {
  Color? color;
  double? size;
  ProgressBar({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: color ?? ColorConfig.primaryColor,
      size: size ?? 42,
    );
  }
}