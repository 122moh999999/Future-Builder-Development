// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'package:zap_sizer/zap_sizer.dart';

class CustomText extends StatelessWidget {
  final String data;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final TextDecoration? decoration;
  const CustomText(this.data,
      {super.key,
      this.color,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.fontSize,
      this.fontWeight,
      this.letterSpacing,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    double? getFontSize() {
      if (context.findAncestorWidgetOfExactType<AppBar>() != null &&
          fontSize == 14) {
        return 18;
      }

      return fontSize;
    }

    FontWeight? getFontWeight() {
      if (context.findAncestorWidgetOfExactType<AppBar>() != null) {
        return FontWeight.w700;
      }
      return fontWeight;
    }

    Color? getColor() {
      return color;
    }

    return Text(
      data,
      key: key,
      style: TextStyle(
        fontFamily: 'Cairo',
        color: getColor(),
        letterSpacing: letterSpacing,
        fontSize: getFontSize()?.sp,
        fontWeight: getFontWeight(),
        decoration: decoration,
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }
}
