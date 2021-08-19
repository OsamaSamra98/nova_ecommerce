import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/screens/Auth/login/login_Screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';

class ActivationScreen extends StatefulWidget {
  final String mobile;

  ActivationScreen({required this.mobile});

  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}


class _ActivationScreenState extends State<ActivationScreen> {
  late TextEditingController _codeEditingController;

  @override
  void initState() {
    super.initState();
    _codeEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _codeEditingController.dispose();
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
              text: 'Hello There',
              color: AppColors.black_COLOR,
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
              title: 'Verification Code',
              controller: _codeEditingController,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.scaleWidth(25)),
              child: ElevatedButton(
                onPressed:  ()async {
              bool status = await UsersGetxController.to.activatedAccount(context, code: _codeEditingController.text, mobile: widget.mobile);
              if(status){
              navigateToLoginScreen();
              }
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
                      Navigator.pushReplacementNamed(context, '/setprofile_screen');
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
            SizedBox(
              height: SizeConfig.scaleHeight(65),
            )
          ],
        ),
      ),
    );
  }
  void navigateToLoginScreen() {
    Get.off(login_Screen());
  }
}
