import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AppColors.dart';
import 'app_text.dart';

class titleWidget extends StatelessWidget {
  final String title;

  final Function() ontap;

  titleWidget({
   required this.title,
   required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          text: title,
          fontWeight: FontWeight.bold,
          fontsize: 17,
          letterSpacing: 1,
        ),
        Spacer(),
        TextButton(
          onPressed: ontap ,
          child: AppText(
            text: 'See More'.tr,
            fontsize: 14,
            color: AppColors.GRAY_COLOR,
            letterSpacing: 1,
          ),
        )
      ],
    );
  }
}
