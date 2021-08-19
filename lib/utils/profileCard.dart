import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'SizeConfig.dart';
import 'app_text.dart';

class profileCard extends StatelessWidget {
  final IconData icon;

  final String text;

  final Color iconColor;
  final Function()? onTap ;

  profileCard({
   required this.icon,
   required this.text,
   required this.onTap,
    this.iconColor = AppColors.Orange_COLOR,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.scaleHeight(25)),
      child: InkWell(
        onTap: onTap,
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
                Icon(icon),
                SizedBox(
                  width: SizeConfig.scaleWidth(25),
                ),
                AppText(
                  text: text ,
                  fontsize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_COLOR,
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
