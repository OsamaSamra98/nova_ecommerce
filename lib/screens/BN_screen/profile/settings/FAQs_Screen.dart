import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/category_widget.dart';

import 'Faqs_widget.dart';

class FAQs_Screen extends StatefulWidget {
  const FAQs_Screen({Key? key}) : super(key: key);

  @override
  _FAQs_ScreenState createState() => _FAQs_ScreenState();
}

class _FAQs_ScreenState extends State<FAQs_Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                text: 'FAQs',
                color: AppColors.black_COLOR,
                fontWeight: FontWeight.bold,
                fontsize: 20,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
