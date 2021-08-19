import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/models/category.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';

import 'SizeConfig.dart';
import 'app_text.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final void Function() onTap;

  CategoryWidget({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.scaleHeight(15))),
          color: AppColors.background_COLOR.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 2)
          ]

        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: CircleAvatar(radius:50 ,
                  backgroundImage: NetworkImage(
                category.imageUrl,
              )),
            ),
            SizedBox(width: SizeConfig.scaleWidth(15)),
            Text(SharedPreferencesController().languageCode == 'ar'
                ? category.nameAr
                : category.nameEn,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'NunitoSans',color: AppColors.black_COLOR),),
          ],
        ),
      ),
    );
  }
}
