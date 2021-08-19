
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/models/sub_category.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/app_text.dart';

import 'AppColors.dart';
import 'SizeConfig.dart';



class SubCategoryWidget extends StatelessWidget {
  final SubCategory subCategory;
  final void Function() onTap;

  SubCategoryWidget({required this.subCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
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
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: CircleAvatar(radius:50 ,
                    backgroundImage: NetworkImage(
                      subCategory.imageUrl,
                    )),
              ),
              SizedBox(width: 15),
              Text(SharedPreferencesController().languageCode == 'ar' ? subCategory.nameAr: subCategory.nameEn),
            ],
          ),
        ),
      ),
    );
  }
}
