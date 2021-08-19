import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/home_getx_controller.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/latestProduct_card.dart';
import 'package:nova_ecommerce/utils/product_card.dart';


class LatestProduct_screen extends StatefulWidget {
  @override
  _LatestProduct_screenState createState() => _LatestProduct_screenState();
}

class _LatestProduct_screenState extends State<LatestProduct_screen> {
  HomeGetxController controller = Get.put(HomeGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(30), vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              AppText(
                text: 'Latest Product',
                color: AppColors.black_COLOR,
                fontWeight: FontWeight.bold,
                fontsize: 20,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              GetX<HomeGetxController>(
                builder: (HomeGetxController home) {
                  if (home.homeModel == null) {
                    return Center(
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
                              text: 'Loading',
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 152 / 266,
                      ),
                      itemCount: home.homeModel!.data.latestProducts.length,
                      itemBuilder: (context, index) {
                        return latestProduct_card(
                            product: home.homeModel!.data.latestProducts[index],
                            onTap: () {});
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
