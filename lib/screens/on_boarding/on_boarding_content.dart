
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';

class OnBoardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String sub_title;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.sub_title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(227)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image),
          SizedBox(
            height: SizeConfig.scaleHeight(40),
          ),
          AppText(
              text: title,
              fontWeight: FontWeight.w700,
              fontsize: 20,
              color: AppColors.black_COLOR,
              textAlign: TextAlign.center),
          SizedBox(
            height: SizeConfig.scaleHeight(15),
          ),
          AppText(
              text: sub_title,
              fontWeight: FontWeight.w400,
              fontsize: 16,
              color: AppColors.black_COLOR,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
