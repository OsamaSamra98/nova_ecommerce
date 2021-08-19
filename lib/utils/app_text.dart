import 'package:flutter/material.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;

  final double fontsize;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final double? letterSpacing;
  final double? height;
  final double shadow;
  late TextDecoration textDecoration;
  late Color decorationColor;

  AppText({
    required this.text,
    this.color = AppColors.black_COLOR,
    this.fontsize = 15,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
    this.height = 0,
    this.shadow = 0,
    this.textDecoration =TextDecoration.none,
    this.decorationColor = Colors.transparent

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          letterSpacing: letterSpacing,
          fontSize: SizeConfig.scaleTextFont(fontsize),
          fontFamily: 'NunitoSans',
          fontWeight: fontWeight,
          height: height,decoration: textDecoration,        decorationColor: decorationColor,

          shadows: [Shadow(color: Colors.black, blurRadius: shadow)]),
    );
  }
}
