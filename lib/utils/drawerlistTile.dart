import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';

class drawerlistTile extends StatelessWidget {
  final String title;
  final Function()? ontap;

  drawerlistTile({required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(25)),
      child: Column(
        children: [
          ListTile(
            onTap: ontap,
            title: AppText(text: title ,color: AppColors.black_COLOR,fontsize: 14,fontWeight: FontWeight.w600 ,),
          ),
        ],
      ),
    );
  }
}
