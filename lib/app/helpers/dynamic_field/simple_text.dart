import 'package:flutter/material.dart';

class TextHelper {
  static Widget titleText(
      {text,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      double? marginTop,
      double? marginBottom,
      double? marginRight,
      TextAlign? textAlign,
      double? marginLeft,
      TextDecoration? decoration,
      FontStyle? fontStyle,
      withOverflow,
      int? maxLine,
      String? font,
      double? spacing}) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(
          top: marginTop != null ? marginTop : 0,
          bottom: marginBottom != null ? marginBottom : 0,
          left: marginLeft != null ? marginLeft : 0,
          right: marginRight != null ? marginRight : 0),
      child: Text(
        text ?? "",
        overflow: withOverflow != null ? TextOverflow.ellipsis : null,
        maxLines: maxLine != null ? maxLine : null,
        strutStyle: StrutStyle(height: spacing),
        textAlign: textAlign != null ? textAlign : TextAlign.start,
        style: TextStyle(
            fontStyle: fontStyle ?? FontStyle.normal,
            fontSize: fontSize ?? 16,
            color: color ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontFamily: font,
            decoration: decoration != null ? decoration : TextDecoration.none),
      ),
    );
  }

  static Widget subTitleText(
      {text,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      double? marginTop,
      double? marginBottom,
      double? marginRight,
      TextAlign? textAlign,
      double? marginLeft,
      TextDecoration? decoration,
      FontStyle? fontStyle,
      withOverflow,
      int? maxLine,
      String? font,
      double? spacing}) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(
          top: marginTop != null ? marginTop : 0,
          bottom: marginBottom != null ? marginBottom : 0,
          left: marginLeft != null ? marginLeft : 0,
          right: marginRight != null ? marginRight : 0),
      child: Text(
        text ?? "",
        overflow: withOverflow != null ? TextOverflow.ellipsis : null,
        maxLines: maxLine != null ? maxLine : null,
        strutStyle: StrutStyle(height: spacing),
        textAlign: textAlign != null ? textAlign : TextAlign.start,
        style: TextStyle(
            fontStyle: fontStyle ?? FontStyle.normal,
            fontSize: fontSize ?? 14,
            color: color ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontFamily: font,
            decoration: decoration != null ? decoration : TextDecoration.none),
      ),
    );
  }
}
