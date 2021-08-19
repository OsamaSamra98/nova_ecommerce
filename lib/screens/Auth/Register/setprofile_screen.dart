import 'package:flutter/material.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';

class setprofile_screen extends StatefulWidget {
  @override
  _setprofile_screenState createState() => _setprofile_screenState();
}

class _setprofile_screenState extends State<setprofile_screen> {
  late TextEditingController _emailEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              text: 'Setting Your Profile',
              color: AppColors.black_COLOR,
              fontsize: 22,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(30),
            ),
            Center(
              child: Container(
                height: SizeConfig.scaleHeight(120),
                width: SizeConfig.scaleWidth(120),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                  color: AppColors.Orange_COLOR.withAlpha(20),

              ),

              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(20),
            ),

            Center(
              child: AppText(
                text: 'Add Profile Picture',
                color: AppColors.Orange_COLOR,
                fontsize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(40),
            ),

            app_textfield(
              title: 'Choose Region',
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.scaleWidth(25)),
              child: ElevatedButton(
                onPressed: () {},
                child: AppText(
                  text: 'Let’s Go',
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
                      Navigator.pushReplacementNamed(context, '/login_Screen');
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
}
