import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/models/product_details.dart';


import 'AppColors.dart';
import 'app_text.dart';

class FavoriteProductWidget extends StatelessWidget {
  final ProductDetails product;
  final void Function() onTap;

  FavoriteProductWidget({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 190,
              width: double.infinity,
              imageUrl: product.imageUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.Orange_COLOR,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: product.nameEn,
                        fontsize: 13,
                        color: AppColors.black_COLOR,
                      ),
                      SizedBox(height: 10,),
                      product.offerPrice == null
                          ? AppText(
                        text: '${product.price}\$',
                        fontsize: 13,
                        color: AppColors.black_COLOR,
                        fontWeight: FontWeight.bold,
                      )
                          : AppText(
                        text: '${product.price}\$',
                        fontsize: 13,
                        color: AppColors.black_COLOR,
                        fontWeight: FontWeight.bold,
                        textDecoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  product.offerPrice != null
                      ? AppText(
                    text: 'Offer: ${product.offerPrice} \$',
                    color: AppColors.Orange_COLOR,
                    fontsize: 13,
                    fontWeight: FontWeight.bold,
                  )
                      : Container(),
                  SizedBox(
                    height: 12,
                  ),
                  AppText(
                    text: '${product.quantity} product available',
                    fontsize: 12,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
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
                      Spacer(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
