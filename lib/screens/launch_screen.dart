import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/cart_getx_controller.dart';
import 'package:nova_ecommerce/getx/order_getx_controller.dart';
import 'package:nova_ecommerce/getx/product_getx_controller.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/screens/BN_screen/main_Screen.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';

import 'on_boarding/on_boarding_screen.dart';

class launch_screen extends StatefulWidget {
  const launch_screen({Key? key}) : super(key: key);

  @override
  _launch_screenState createState() => _launch_screenState();
}

class _launch_screenState extends State<launch_screen> {
  UsersGetxController usersController = Get.put(UsersGetxController());
  ProductGetxController controller = Get.put(ProductGetxController());
  OrderGetxController orderGetxController = Get.put(OrderGetxController());
  CartGetxController cartGetxController = Get.put(CartGetxController());

  @override
  void initState() {
    Widget route = SharedPreferencesController().loggedIn
        ? main_Screen()
        : OnBoardingScreen();
    Future.delayed(Duration(seconds: 3), () => Get.off(route));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(122)),
              child: Row(
                children: [
                  SvgPicture.asset('images/launch_icon.svg'),
                  SizedBox(
                    width: SizeConfig.scaleWidth(20),
                  ),
                  Text(
                    'Nova Store',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(28),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NunitoSans'
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
