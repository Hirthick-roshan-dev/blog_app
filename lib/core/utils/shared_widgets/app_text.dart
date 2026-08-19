import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;

  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;

  const AppText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.overflow, this.maxLines = 1, this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        decoration: decoration,
        fontStyle: fontStyle,
        color: color ?? AppColors.primary,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontSize:  fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}