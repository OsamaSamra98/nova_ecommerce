import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/product_card.dart';

import 'DetailsScreen.dart';

class ProductScreen extends StatefulWidget {
  final int id;
  final String name;

  ProductScreen({required this.id, required this.name});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductGetxController controller = Get.put(ProductGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to.getProduct(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: widget.name,
          fontsize: SizeConfig.scaleTextFont(24),
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(25)),
        child: Container(
          child: GetX<ProductGetxController>(
            builder: (ProductGetxController controller) {
              return controller.loading.value
                  ? Center(
                      child: GradientProgressIndicator(
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
                              text: 'loading',
                              fontsize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    )
                  : controller.products.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 152 / 266,
                          ),
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return product_card(
                                product: controller.products[index],
                                onTap: () => Get.to(
                                      DetailsScreen(
                                          productDetails:
                                              controller.products[index]),
                                    ));
                          },
                        )
                      : Center(
                          child: GradientProgressIndicator(
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
                                  text: 'There is no product yet ',
                                  fontsize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }
}
