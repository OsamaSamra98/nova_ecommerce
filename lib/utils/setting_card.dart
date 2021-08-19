import 'package:flutter/material.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';

import 'AppColors.dart';
import 'app_text.dart';

class setting_card extends StatelessWidget {
  final String title;
  final Function() ontap;
  final IconData icon ;

  setting_card({
   required this.title,
   required this.ontap,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: SizeConfig.scaleHeight(15)),
      child: InkWell(
        onTap:ontap,
        child: Container(
          height: SizeConfig.scaleHeight(70),
          width: SizeConfig.scaleWidth(350),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, -1), blurRadius: 2)
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.scaleHeight(15),
                horizontal: SizeConfig.scaleWidth(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                AppText(
                  text: title,
                  fontsize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_COLOR,
                ),
                Spacer(),
                Icon(
                  icon,
                  color: AppColors.Orange_COLOR,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
