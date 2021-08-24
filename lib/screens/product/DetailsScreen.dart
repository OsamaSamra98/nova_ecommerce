import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nova_ecommerce/getx/cart_getx_controller.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/mixins/helpers.dart';
import 'package:nova_ecommerce/models/cart_item.dart';
import 'package:nova_ecommerce/models/product_details.dart';
import 'package:nova_ecommerce/screens/BN_screen/main_Screen.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/helper.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  final ProductDetails productDetails;

  DetailsScreen({required this.productDetails});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int cardIncrement = 1;
  CartGetxController cartGetxController = Get.put(CartGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to
          .getProductDetails(id: widget.productDetails.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart_screen');
              },
              icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.scaleWidth(65),
            vertical: SizeConfig.scaleHeight(30)),
        child: Container(
          height: SizeConfig.scaleHeight(280),
          width: SizeConfig.scaleWidth(280),
          child: CarouselSlider(
            options: CarouselOptions(
              height: SizeConfig.scaleHeight(445),
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: ProductGetxController.to.productDetails.value!.images
                .map((ProductImages image) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(
                    image.imageUrl,
                    fit: BoxFit.cover,
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
      bottomSheet: Container(
        height: SizeConfig.scaleHeight(355),
        width: SizeConfig.scaleWidth(400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(15),
              ),
              Row(
                children: [
                  AppText(
                    text: SharedPreferencesController().languageCode == 'ar'
                        ? widget.productDetails.nameAr
                        : widget.productDetails.nameEn,
                    fontsize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black_COLOR,
                    letterSpacing: 1,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await ProductGetxController.to.addFavoriteProducts(
                          context: context,
                          product:
                              ProductGetxController.to.productDetails.value!);
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ProductGetxController
                                  .to.productDetails.value!.isFavorite
                              ? Colors.red
                              : Colors.grey),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: double.parse(ProductGetxController
                        .to.productDetails.value!.productRate
                        .toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemSize: 30,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      ProductGetxController.to.rattingProduct(
                          product: widget.productDetails,
                          context: context,
                          rate: rating);
                    },
                  ),
                  SizedBox(
                    width: SizeConfig.scaleWidth(5),
                  ),
                  AppText(
                    text:
                        '(${ProductGetxController.to.productDetails.value!.overalRate})',
                    fontsize: SizeConfig.scaleTextFont(12),
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(15),
              ),

              RichText(
                text: TextSpan(
                  text: ('Product available : ').tr,
                  style: TextStyle(
                      fontSize: 12, color: AppColors.black_COLOR),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                        '${ProductGetxController.to.productDetails.value!.quantity} ',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              Row(
                children: [
                  ProductGetxController.to.productDetails.value!.offerPrice !=
                          null
                      ? AppText(
                          text:
                              'Was : ${ProductGetxController.to.productDetails.value!.price} \$ ',
                          fontsize: 15,
                          color: AppColors.black_COLOR,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                        )
                      : RichText(
                          text: TextSpan(
                            text: ('Price :  ').tr,
                            style: TextStyle(
                                fontSize: 17, color: AppColors.black_COLOR),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${ProductGetxController.to.productDetails.value!.price} \$',
                                  style: TextStyle(fontSize: 17)),
                            ],
                          ),
                        ),
                  SizedBox(
                    width: SizeConfig.scaleWidth(20),
                  ),
                  ProductGetxController.to.productDetails.value!.offerPrice !=
                          null
                      ? AppText(
                          text:
                              'Now :   ${ProductGetxController.to.productDetails.value!.offerPrice} \$',
                          color: AppColors.kPrimaryColor,
                          fontsize: 15,
                          fontWeight: FontWeight.bold,
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(25),
              ),
              AppText(
                text: 'Description : '.tr,
                fontsize: 20,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(15),
              ),
              Text(
                  SharedPreferencesController().languageCode == 'ar'
                      ? widget.productDetails.infoAr
                      : widget.productDetails.infoEn,
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.scaleWidth(200),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool status = await CartGetxController.to
                            .createCartItem(cartItem);
                        if (status) {
                          Helper.showSnackBar(context, text: 'Add Success');
                          cardIncrement;
                        } else {
                          Helper.showSnackBar(context, text: 'Add failed');
                          cardIncrement;
                        }
                      },
                      child: AppText(
                        text: 'Add To Cart'.tr,
                        color: AppColors.background_COLOR,
                        fontsize: SizeConfig.scaleTextFont(20),
                        fontWeight: FontWeight.bold,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.Orange_COLOR,
                          minimumSize: Size(double.infinity, 64),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: SizeConfig.scaleWidth(125),
                    child: Row(
                      children: [
                        FloatingActionButton(
                          backgroundColor: AppColors.black_COLOR,
                          mini: true,
                          onPressed: () {
                            setState(() {
                              ++cardIncrement;
                            });
                          },
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                            text: cardIncrement.toString(),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: AppColors.black_COLOR,
                          mini: true,
                          onPressed: () {
                            setState(() {
                              cardIncrement == 1 ? 1 : --cardIncrement;
                            });
                          },
                          child: Icon(
                            Icons.remove,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildOutlineButton(
      {required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

  CartItem get cartItem {
    CartItem cartItem = CartItem();
    cartItem.imageUrl = widget.productDetails.imageUrl;
    cartItem.productId = widget.productDetails.id;
    cartItem.price = widget.productDetails.price;
    cartItem.nameEn = widget.productDetails.nameEn;
    cartItem.nameAr = widget.productDetails.nameAr;
    cartItem.quantity = cardIncrement;
    return cartItem;
  }
}
