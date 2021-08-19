import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';

import 'SizeConfig.dart';

class productScreen extends StatelessWidget {
  final String text;
  final String subtext;
  final String image;

  productScreen({
    required this.text,
    required this.subtext,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset('images/${image}.svg'),
        SingleChildScrollView(
          child: Container(
            height: SizeConfig.scaleHeight(300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 300,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.scaleHeight(25),
                ),
                AppText(
                  text: text,
                  fontsize: SizeConfig.scaleTextFont(22),fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(25),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(53)),
                  child: AppText(
                    text: subtext,
                    fontsize: SizeConfig.scaleTextFont(16),
                    textAlign: TextAlign.center,color: AppColors.black_COLOR.withAlpha(60),
                  ),
                ),
                Divider(color: Colors.transparent,),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
