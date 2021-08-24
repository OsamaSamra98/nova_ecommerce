import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/home_getx_controller.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/screens/BN_screen/home/sub_categoey_screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/category_card.dart';
import 'package:nova_ecommerce/utils/latestProduct_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nova_ecommerce/utils/famousProduct_card.dart';
import 'package:nova_ecommerce/utils/titleWidget.dart';

import 'LatestProduct_screen.dart';
import 'categories_screen.dart';

class home_screen extends StatefulWidget {
  HomeGetxController controller = Get.put(HomeGetxController());
  UsersGetxController usersController = Get.put(UsersGetxController());

  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(

        body: GetBuilder<HomeGetxController>(
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
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 2,
                    autoPlay: true,
                  ),
                  items: images(),
                ),
              ),
              titleWidget(
                title: 'Categories'.tr,
                ontap: () => Get.to(categories_screen()),
              ),
              home.homeModel == null
                  ? Container()
                  : SizedBox(
                      height: SizeConfig.scaleHeight(100),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                              category: home.homeModel!.data.categories[index],
                              onTap: () => Get.to(SubCategoryScreen(
                                  id: home.homeModel!.data.categories[index].id,
                                  name: myLocale.languageCode == 'ar'
                                      ? home.homeModel!.data.categories[index]
                                          .nameAr
                                      : home.homeModel!.data.categories[index]
                                          .nameEn)));
                        },
                      ),
                    ),

              titleWidget(
                title: 'Latest Product'.tr,
                ontap: () {}
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(450),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 152 / 185,
                  ),
                  // itemCount: home.homeModel!.data.latestProducts.length,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return latestProduct_card(
                        product: home.homeModel!.data.latestProducts[index],
                        onTap: () {});
                  },
                ),
              ),
              titleWidget(
                title: 'Products you may like'.tr,
                ontap: () => Get.to(''),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(260),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: home.homeModel!.data.famousProducts.length,
                  itemBuilder: (context, index) {
                    return famousProduct_card(
                        product: home.homeModel!.data.famousProducts[index],
                        onTap: () {});
                  },
                ),
              ),
            ]),
          ),
        );
      },
    ));
  }

  List<Widget> images() {
    return widget.controller.homeModel!.data.slider
        .map((e) => Container(
              margin: EdgeInsets.all(SizeConfig.scaleHeight(5)),

              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        e.imageUrl,
                        height: double.infinity,
                      ),
                    ],
                  )),
            ))
        .toList();
  }
}
