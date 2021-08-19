import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/settings/changePassword.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/profileCard.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.scaleWidth(25),
            right: SizeConfig.scaleWidth(25),
            top: SizeConfig.scaleHeight(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'Edit Profile',
              fontWeight: FontWeight.bold,
              fontsize: 20,
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(30),
            ),
            app_textfield(
              title: 'Name',
              rightpadding: 0,
            ),
            app_textfield(
              title: 'Mobile',
              rightpadding: 0,
              toppadding: 20,
            ),
            app_textfield(
              title: 'Password',
              rightpadding: 0,
              toppadding: 20,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: AppText(
                text: 'Save Changes',
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
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(changePassword_screen());
              },
              child: AppText(
                text: 'Change Password',
                color: Colors.white,
                fontsize: 16,
                fontWeight: FontWeight.bold,
              ),
              style: ElevatedButton.styleFrom(
                  primary: AppColors.Orange_COLOR.withAlpha(100),
                  minimumSize: Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(100),
            ),
          ],
        ),
      ),
    );
  }
}
