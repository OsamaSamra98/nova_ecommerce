import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/screens/Auth/login/reset_password_screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/helper.dart';

class forgetPassword_screen extends StatefulWidget {
  @override
  _forgetPassword_screenState createState() => _forgetPassword_screenState();
}

class _forgetPassword_screenState extends State<forgetPassword_screen> {

  late TextEditingController _phoneEditingController;
  @override
  void initState() {
    super.initState();
    _phoneEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneEditingController.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'Forgot Password',
              color: AppColors.black_COLOR,
              fontsize: 22,
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(25),
            ),
            AppText(
              text:
                  'Don’t worry, create your new password',
              color: AppColors.GRAY_COLOR,
              fontsize: 16,
              fontWeight: FontWeight.bold,
            ),
            app_textfield(
              title: 'Mobile ',
              controller: _phoneEditingController,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.scaleWidth(25)),
              child: ElevatedButton(
                onPressed: ()async {
                  await performForgetPassword();
                },
                child: AppText(
                  text: 'Confirm',
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
            SizedBox(
              height: SizeConfig.scaleHeight(65),
            )
          ],
        ),
      ),
    );
  }
  Future performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_phoneEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    return false;
  }

  Future forgetPassword() async {
    bool status = await UsersGetxController.to.forgetPassword(context, mobile: _phoneEditingController.text);
    if (status) {
      navigateToResetPassword();
    } else {
      Helper.showSnackBar(
          context,
          text: 'Login failed, check your credentials!',
          error: true);
    }

  }

  void navigateToResetPassword() {
    Get.to(ResetPasswordScreen(phone: _phoneEditingController.text,));
  }
}


