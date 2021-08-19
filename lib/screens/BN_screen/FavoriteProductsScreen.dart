import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/screens/product/DetailsScreen.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/favorite_product_widget.dart';


class FavoriteProductsScreen extends StatefulWidget {
  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to.getFavoriteProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetX<ProductGetxController>(
            builder: (ProductGetxController controller) {
              return controller.loading.value
                  ? Center(child: GradientProgressIndicator(
                radius: 100,
                duration: 3,
                strokeWidth: 12,
                gradientStops: const [
                  0.2,
                  0.8,
                ],
                gradientColors: const [
                  Colors.orange,
                  Colors.orangeAccent,
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: 'Loading',
                      fontsize: 20,fontWeight: FontWeight.bold,
                    ),

                  ],
                ),
              ),)
                  : controller.favoriteProducts.isNotEmpty
                  ? GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.favoriteProducts.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 146 / 250,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return FavoriteProductWidget(
                      product: controller.favoriteProducts[index],
                      onTap: () => Get.to(
                        DetailsScreen(
                            productDetails:
                            controller.favoriteProducts[index]),
                      ));
                },
              )
                  : Center(child: Text('no data'));
            }),
        padding: EdgeInsets.symmetric(horizontal: 29, vertical: 25),

      ),
    );
  }
}
