import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/language/app_locale.dart';
import 'package:nova_ecommerce/screens/BN_screen/home/about_Screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/helper.dart';
import 'package:nova_ecommerce/utils/setting_card.dart';

import 'FAQs_Screen.dart';

class setting_Screen extends StatefulWidget {
  const setting_Screen({Key? key}) : super(key: key);

  @override
  _setting_ScreenState createState() => _setting_ScreenState();
}

class _setting_ScreenState extends State<setting_Screen> {
  late TextEditingController _subjectEditingController;
  late TextEditingController _msgEditingController;

  @override
  void initState() {
    super.initState();
    _subjectEditingController = TextEditingController();
    _msgEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectEditingController.dispose();
    _msgEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.scaleHeight(50), left: SizeConfig.scaleWidth(25),right: SizeConfig.scaleWidth(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setting_card(title: 'Change Language'.tr, ontap: () {
              AppLocale.changeLang();
            }, icon: Icons.compare_arrows,),
            setting_card(title: 'FAQs'.tr, ontap: () {
              Get.to(FAQs_Screen());
            },),
            setting_card(title: 'About'.tr, ontap: () {
              Get.to(about_Screen());
            },),
            SizedBox(height: SizeConfig.scaleHeight(20),),
            AppText(
              text: 'Contact Us'.tr,
              fontsize: 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            Container(
              width: SizeConfig.scaleWidth(350),
              height: SizeConfig.scaleHeight(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -1),
                      blurRadius: 2)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _subjectEditingController,
                  style: TextStyle(
                    color: AppColors.black_COLOR,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Subject'.tr,
                      hintStyle: TextStyle(
                          color: AppColors.GRAY_COLOR,
                          fontSize: SizeConfig.scaleTextFont(16),
                          fontFamily: 'NunitoSans'),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            Container(
              width: SizeConfig.scaleWidth(350),
              height: SizeConfig.scaleHeight(200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -1),
                      blurRadius: 2)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _msgEditingController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  style: TextStyle(
                    color: AppColors.black_COLOR,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Message'.tr,
                      hintStyle: TextStyle(
                          color: AppColors.GRAY_COLOR,
                          fontSize: SizeConfig.scaleTextFont(16),
                          fontFamily: 'NunitoSans'),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(100),
                  vertical: SizeConfig.scaleHeight(25)),
              child: ElevatedButton(
                onPressed: () async => await performContactUs(),
                child: AppText(
                  text: 'Send'.tr,
                  color: Colors.white,
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.Orange_COLOR,
                    minimumSize: Size(double.infinity, 64),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future performContactUs() async {
    if (checkData()) {
      await contactUs();
    }
  }

  bool checkData() {
    if (_subjectEditingController.text.isNotEmpty &&
        _msgEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields'.tr, error: true);
    return false;
  }

  Future contactUs() async {
    bool status = await UsersGetxController.to.contactUs(
        context, subject: _subjectEditingController.text,
        msg: _msgEditingController.text);
  }
}

