import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/models/product_details.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';


class ProductDetailsScreen extends StatefulWidget {
  final int productID;

  ProductDetailsScreen({required this.productID});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to.getProductDetails(id: widget.productID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: GetX<ProductGetxController>(
        builder: (ProductGetxController controller) {
          return controller.loading.value  ? Center(child: CircularProgressIndicator())

              :Stack(
            children: [
              SizedBox(
                height: 445,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 445,
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
                        return CachedNetworkImage(
                          height: 400,
                          width: double.infinity,
                          imageUrl: image.imageUrl,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.Orange_COLOR,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  height: 413,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: ProductGetxController
                                  .to.productDetails.value!.nameEn,
                              color: Colors.black,
                              fontsize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await ProductGetxController.to
                                    .addFavoriteProducts(
                                    context: context,
                                    product: ProductGetxController
                                        .to.productDetails.value!);
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ProductGetxController
                                        .to
                                        .productDetails
                                        .value!
                                        .isFavorite
                                        ? Colors.red
                                        : Colors.grey),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ProductGetxController.to.productDetails.value!
                            .offerPrice !=
                            null
                            ? AppText(
                          text:
                          'Price : ${ProductGetxController.to.productDetails.value!.price} \$  + ${ProductGetxController.to.productDetails.value!.offerPrice}',
                          color: Colors.black,
                          fontsize: 21,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        )
                            : AppText(
                          text:
                          'Price : ${ProductGetxController.to.productDetails.value!.price} \$',
                          color: Colors.black,
                          fontsize: 21,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppText(
                          text: ProductGetxController
                              .to.productDetails.value!.infoEn,
                          color: Colors.grey,
                          fontsize: 16,
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          );


        })

        );
  }
}
