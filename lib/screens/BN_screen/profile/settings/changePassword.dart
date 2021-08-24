import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/helper.dart';

class changePassword_screen extends StatefulWidget {
  const changePassword_screen({Key? key}) : super(key: key);

  @override
  _changePassword_screenState createState() => _changePassword_screenState();
}

class _changePassword_screenState extends State<changePassword_screen> {
  late TextEditingController _oldPasswordEditingController;
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;

  @override
  void initState() {
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
    _oldPasswordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _oldPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.scaleWidth(25),
              right: SizeConfig.scaleWidth(25),
              top: SizeConfig.scaleHeight(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Change Password'.tr,
                fontWeight: FontWeight.bold,
                fontsize: 22,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              app_textfield(
                title: 'Current Password'.tr,
                rightpadding: 0,
                toppadding: 20,
                controller: _oldPasswordEditingController,
              ),
              app_textfield(
                title: 'Enter new password'.tr,
                rightpadding: 0,
                toppadding: 20,
                controller: _newPasswordEditingController,
              ),
              app_textfield(
                title: 'Repeat password'.tr,
                rightpadding: 0,
                toppadding: 20,
                controller: _newPasswordConfirmationEditingController,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(280),
              ),
              ElevatedButton(
                onPressed: () {performChangePassword();},
                child: AppText(
                  text: 'Confirm'.tr,
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
            ],
          ),
        ),
      ),
    );
  }

  Future performChangePassword() async {
    if (checkData()) {
      await changePassword();
    }
  }

  bool checkData() {
    if (isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      Helper.showSnackBar(context,
          text: 'Password is not confirmed correctly!', error: true);
    } else {
      Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty &&
        _oldPasswordEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  Future changePassword() async {
    bool status = await UsersGetxController.to.changePassword(context,
        currentPassword: _oldPasswordEditingController.text,
        newPassword: _newPasswordConfirmationEditingController.text);
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.back();
  }
}
