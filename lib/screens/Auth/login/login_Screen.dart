import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/firebase/fb_notifications.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/mixins/helpers.dart';
import 'package:nova_ecommerce/screens/Auth/Register/signup_screen.dart';
import 'package:nova_ecommerce/screens/Auth/login/forgetPassword_screen.dart';
import 'package:nova_ecommerce/screens/BN_screen/main_Screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/helper.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({Key? key}) : super(key: key);

  @override
  _login_ScreenState createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> with FbNotifications,Helpers{
  late TextEditingController phoneEditingController;
  late TextEditingController passwordEditingController;
  late TapGestureRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    phoneEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    recognizer = TapGestureRecognizer();
    recognizer.onTap = navigateToCreateAccountScreen;
    requestNotificationPermissions();
  }

  @override
  void dispose() {
    phoneEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  navigateToCreateAccountScreen() {
    Get.to(signup_screen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_COLOR,
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
                text: 'Welcome Back',
                color: AppColors.black_COLOR,
                fontsize: 22,
                fontWeight: FontWeight.bold,
              ),
              app_textfield(
                title: 'Mobile',
                controller:phoneEditingController ,
              ),
              app_textfield(
                title: 'Password',
                controller:passwordEditingController ,

                toppadding: 20,
                secure: true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.scaleWidth(240)),
                child: TextButton(
                  onPressed: () => Get.to(forgetPassword_screen()),
                  child: AppText(
                    text: 'Forgot Password?',
                    color: AppColors.Orange_COLOR,
                    fontsize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.scaleWidth(25),
                    top: SizeConfig.scaleHeight(265)),
                child: ElevatedButton(
                  onPressed: () async {
                    await performLogin();
                  },
                  child: AppText(
                    text: 'Login',
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
                    EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(50)),
                child: Row(
                  children: [
                    AppText(
                      text: 'Don’t have an account? Please',
                      color: AppColors.black_COLOR,
                      fontsize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(signup_screen());

                      },
                      child: AppText(
                        text: 'Sign Up',
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
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (phoneEditingController.text.isNotEmpty &&
        passwordEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> login() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCMToken => ${fcmToken}');
    bool status = await UsersGetxController.to.login(
      context: context,
      mobile: phoneEditingController.text,
      password: passwordEditingController.text,
      newFcmToken: fcmToken.toString(),


    );
    if (status) {
      Get.offAll(main_Screen());
    } else {
      Helper.showSnackBar(context, text: 'Login failed, check your credentials!', error: true);
    }
  }
}

