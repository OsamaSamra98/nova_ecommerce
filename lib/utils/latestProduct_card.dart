import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/models/Home.dart';
import 'package:nova_ecommerce/models/product.dart';
import 'package:nova_ecommerce/screens/product/DetailsScreen.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:get/get.dart';

class latestProduct_card extends StatelessWidget {
  final Latest_products product;
  final void Function() onTap;

  latestProduct_card({
    required this.product,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.scaleWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: SizeConfig.scaleWidth(152),
              height: SizeConfig.scaleHeight(150),clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.darkGRAY_COLOR,

              ),
              child: CachedNetworkImage(imageUrl: product.imageUrl,fit: BoxFit.cover,),
            ),
          ),
          SizedBox(
            height: SizeConfig.scaleHeight(15),
          ),

          Text(SharedPreferencesController().languageCode == 'ar'
              ? product.nameAr
              : product.nameEn, style: TextStyle(fontSize: SizeConfig.scaleTextFont(13),
            color: AppColors.black_COLOR,
            fontWeight: FontWeight.bold,fontFamily: 'NunitoSans'),),
          SizedBox(
            height: SizeConfig.scaleHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              product.offerPrice == null
                  ? AppText(
                text: '${product.price} \$',
                fontsize: 17,
                color: AppColors.Orange_COLOR,fontWeight: FontWeight.bold,
              )
                  : AppText(
                text: 'Price :  '.tr + '${product.price} \$',
                fontsize: 13,
                color: AppColors.black_COLOR,
                textDecoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
              ),

              product.offerPrice != null
                  ? AppText(
                text: 'Offer : '.tr + '${product.offerPrice} \$',
                color: AppColors.Orange_COLOR,
                fontsize: 13,
                fontWeight: FontWeight.bold,
              )
                  : Container(),
            ],
          ),


        ],
      ),
    );
  }
}
