import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/categories_getx_controller.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/category_card.dart';
import 'package:nova_ecommerce/utils/category_widget.dart';

import 'sub_categoey_screen.dart';

class categories_screen extends StatefulWidget {
  const categories_screen({Key? key}) : super(key: key);

  @override
  _categories_screenState createState() => _categories_screenState();
}

class _categories_screenState extends State<categories_screen> {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30),vertical: 10 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              AppText(
                text: 'Category',
                color: AppColors.black_COLOR,
                fontWeight: FontWeight.bold,
                fontsize: 20,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              GetX<CategoryGetxController>(
                builder: (CategoryGetxController controller) {
                  return controller.categories.isEmpty
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
                          text: 'Loading',
                          fontsize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryWidget(
                                category: controller.categories[index],
                                onTap: () => Get.to(SubCategoryScreen(
                                      id: controller.categories[index].id,
                                      name: myLocale.languageCode == 'ar'
                                          ? controller.categories[index].nameAr
                                          : controller.categories[index].nameEn,
                                    )));
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: SizeConfig.scaleHeight(15),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
