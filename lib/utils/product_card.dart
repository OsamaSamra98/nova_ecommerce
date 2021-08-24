import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/models/Home.dart';
import 'package:nova_ecommerce/models/product.dart';
import 'package:nova_ecommerce/models/product_details.dart';
import 'package:nova_ecommerce/screens/product/DetailsScreen.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:get/get.dart';

class product_card extends StatelessWidget {
  final ProductDetails product;
  final void Function() onTap;

  product_card(
      {
    required this.product,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.scaleWidth(20)),
      child: Container(
        width: SizeConfig.scaleWidth(152),
        height: SizeConfig.scaleHeight(280),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                width: SizeConfig.scaleWidth(152),
                height: SizeConfig.scaleHeight(180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.darkGRAY_COLOR,
                ),
                child: Image.network(product.imageUrl,fit: BoxFit.cover,),
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            AppText(
              text: SharedPreferencesController().languageCode == 'ar'
                ? product.nameAr
                : product.nameEn,
              fontsize: 13,
              color: AppColors.black_COLOR,
              fontWeight: FontWeight.bold,

            ),SizedBox(
              height: SizeConfig.scaleHeight(20),
            ),
            Row(
              children: [
                product.offerPrice == null
                    ? AppText(
                  text: 'Price :  '.tr +'${product.price} \$',
                  fontsize: 13,
                  color: AppColors.black_COLOR,
                )
                    : AppText(
                  text: 'Price :  '.tr +'${product.price} \$',
                  fontsize: 13,
                  color: AppColors.black_COLOR,
                  fontWeight: FontWeight.bold,
                  textDecoration: TextDecoration.lineThrough,
                  decorationColor: Colors.red,
                ),
               Spacer(),

                product.offerPrice != null
                    ? AppText(
                  text: 'Offer : '.tr +'${product.offerPrice} \$',
                  color: AppColors.Orange_COLOR,
                  fontsize: 13,
                  fontWeight: FontWeight.bold,
                )
                    : Container(),
              ],
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(5),
            ),

            Row(
              children: [
                Icon(Icons.star,color: Colors.amber,size: 15,),
                SizedBox(width: 5,),
                AppText(
                  text: '(${product.overalRate})',
                  fontsize: 10,
                  color: Colors.grey,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
