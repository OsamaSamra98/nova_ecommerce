import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/categories_getx_controller.dart';
import 'package:nova_ecommerce/screens/product/product_screen.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/sub_category_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  final int id;
  final String name;

  SubCategoryScreen({required this.id, required this.name});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  void initState() {
    controller.getSubCategories(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppText(
          text: widget.name,
          fontsize: SizeConfig.scaleTextFont(24),
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 15),
        child: Container(
          child: GetX<CategoryGetxController>(
            builder: (CategoryGetxController controller) {
              return controller.subCategories.isEmpty
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
                      itemCount: controller.subCategories.length,
                      itemBuilder: (context, index) {
                        return SubCategoryWidget(
                            subCategory: controller.subCategories[index],
                            onTap: () => Get.to(ProductScreen(
                                  id: controller.subCategories[index].id,
                                  name: myLocale.languageCode == 'ar'
                                      ? controller.subCategories[index].nameAr
                                      : controller.subCategories[index].nameEn,
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
        ),
      ),
    );
  }
}
