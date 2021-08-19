import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/screens/Auth/login/login_Screen.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/crediteCard.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/settings/editprofile.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/settings/settingScreen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/helper.dart';
import 'package:nova_ecommerce/utils/profileCard.dart';

import 'address/address_screen.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  _profile_screenState createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: 'Profile',
          fontWeight: FontWeight.bold,
          fontsize: 20,
        ),
        actions: [IconButton(onPressed: () {Get.to(setting_Screen());}, icon: Icon(Icons.settings))],
      ),
      resizeToAvoidBottomInset: true,

      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.scaleWidth(25),
              right: SizeConfig.scaleWidth(25),
              top: SizeConfig.scaleHeight(25)),
          child: Column(
            children: [
              profileCard(
                icon: Icons.person,
                text: 'Edit Profile',
                onTap: () =>Get.to(EditProfile()) ,
              ),
              profileCard(
                icon: Icons.shopping_bag_outlined,
                text: 'My Purchases',
                onTap: () {},
              ),
              profileCard(
                icon: Icons.notifications_active_outlined,
                text: 'Notifications ',
                onTap: () {},
              ),
              profileCard(
                icon: Icons.credit_card_outlined,
                text: ' PAYMENT CARDS',
                onTap: () {Get.to(DisplayCardScreen());},
              ),
              profileCard(
                icon: Icons.add_location,
                text: 'My Address',
                onTap: () {Get.to(AddressScreen());},
              ),
              profileCard(
                icon: Icons.logout,
                text: 'Logout',
                iconColor: Colors.white,
                onTap: () async {
                  await logout();},
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> logout() async {
    bool status = await UsersGetxController.to.logout(context);
    if (status) {
      Get.off(login_Screen());
    } else {
      Helper.showSnackBar(context, text: 'Logout failed, ', error: true);
    }
  }
}
