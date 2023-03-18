import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

class Helper {
  late BuildContext context;

  static getCurrency(double value, {needSymbol = true}) {
    final usd = Currency.create('USD', 0, symbol: needSymbol ? 'USD ' : '', pattern: 'S #,#0', invertSeparators: true);
    var result = Money.fromNumWithCurrency(value, usd);
    return result;
  }

  static BorderRadiusGeometry getRadius(double radius,
      {bool? isAll = true, double? radiusTopRight = 0.0, double? radiusBottomRight = 0.0, double? radiusBottomLeft = 0.0}) {
    return isAll == true
        ? BorderRadius.all(Radius.circular(radius))
        : BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radiusBottomLeft!),
            bottomRight: Radius.circular(radiusBottomRight!),
            topRight: Radius.circular(radiusTopRight!),
          );
  }
}