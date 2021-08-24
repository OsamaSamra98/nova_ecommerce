import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/models/product_details.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';


import 'AppColors.dart';
import 'SizeConfig.dart';
import 'app_text.dart';
import 'package:get/get.dart';

class FavoriteProductWidget extends StatelessWidget {
  final ProductDetails product;
  final void Function() onTap;

  FavoriteProductWidget({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5),
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding:  EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
                  child: Image.network(product.imageUrl,fit: BoxFit.cover,),
                ),
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
              height: SizeConfig.scaleHeight(20),
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
