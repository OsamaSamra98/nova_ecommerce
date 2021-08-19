import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/models/city.dart';
import 'package:nova_ecommerce/screens/Auth/Register/signupverification_screen.dart';
import 'package:nova_ecommerce/screens/Auth/login/login_Screen.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/helper.dart';

import 'cities_screen.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  _signup_screenState createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  City? city;
  bool isMale = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_COLOR,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.scaleWidth(25), top: SizeConfig.scaleHeight(130)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Hello There',
                color: AppColors.GRAY_COLOR,
                fontsize: 16,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(25),
              ),
              AppText(
                text: 'Create Your Account',
                color: AppColors.black_COLOR,
                fontsize: 22,
                fontWeight: FontWeight.bold,
              ),
              app_textfield(
                title: 'Full Name',
                controller: nameController,
              ),
              app_textfield(
                title: 'Mobile',
                controller: phoneController,
                toppadding: 20,
              ),
              app_textfield(
                title: 'Password',
                controller: passwordController,
                toppadding: 20,
                secure: true,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: GestureDetector(
                  onTap: () async {
                    City selectedCity = await Get.to(CitiesScreen());
                    setState(() {
                      city = selectedCity;
                    });
                  },
                  child: Container(
                    height: SizeConfig.scaleHeight(62),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XFF000000).withAlpha(20),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, top: 25, bottom: 20, right: 25),
                      child: Row(
                        children: [
                          getCityName(),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: AppColors.Orange_COLOR,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: AppColors.Orange_COLOR,
                      value: isMale,
                      onChanged: (var selected) {
                        setState(() {
                          isMale = true;
                        });
                      },
                      title: AppText(
                        text: 'Male',
                        fontsize: 16,
                        color: AppColors.Orange_COLOR,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.red,
                    width: 50,
                    thickness: 5,
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: AppColors.Orange_COLOR,
                      value: !isMale,
                      onChanged: (var selected) {
                        setState(() {
                          isMale = false;
                        });
                      },
                      title: AppText(
                        text: 'Female',
                        fontsize: 16,
                        color: AppColors.Orange_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.scaleWidth(25),
                    top: SizeConfig.scaleHeight(100)),
                child: ElevatedButton(
                  onPressed: () async {
                    await performRegister();
                  },
                  child: AppText(
                    text: 'Continue',
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
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(70)),
                child: Row(
                  children: [
                    AppText(
                      text: 'You have an account? Please',
                      color: AppColors.black_COLOR,
                      fontsize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(login_Screen());
                      },
                      child: AppText(
                        text: 'Sign In',
                        color: AppColors.Orange_COLOR,
                        fontsize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCityName() {
    if (city == null) {
      return AppText(
        text: 'Select City',
        color: Colors.grey,
      );
    } else {
      if (SharedPreferencesController().languageCode == 'ar') {
        return AppText(
          text: city!.nameAr,
          color: AppColors.Orange_COLOR,
          fontsize: 16,
        );
      } else {
        return AppText(
          text: city!.nameEn,
          color: AppColors.Orange_COLOR,
          fontsize: 16,
        );
      }
    }
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        city != null) {
      return true;
    }
    return false;
  }

  Future<void> register() async {
    int? code = await UsersGetxController.to.register(
        context: context,
        name: nameController.text,
        mobile: phoneController.text,
        password: passwordController.text,
        gender: isMale ? 'M' : 'F',
        city: city!.id);
    if (code != null) {
      Helper.showSnackBar(context, text: code.toString(), error: true);
      Get.off(ActivationScreen(mobile: phoneController.text));
    }
  }
}
