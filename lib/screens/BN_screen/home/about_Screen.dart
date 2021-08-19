import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';

class about_Screen extends StatefulWidget {
  const about_Screen({Key? key}) : super(key: key);

  @override
  _about_ScreenState createState() => _about_ScreenState();
}

class _about_ScreenState extends State<about_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.background_COLOR,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset('images/launch_icon.svg'),
              SizedBox(
                height: SizeConfig.scaleWidth(25),
              ),
              AppText(
                text: 'Nova Store',
                fontsize: SizeConfig.scaleTextFont(28),
                fontWeight: FontWeight.bold,
              ),
              Spacer(),
              AppText(
                text: 'Osama Abo Samra - GGatway',
                fontsize: SizeConfig.scaleTextFont(28),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: SizeConfig.scaleWidth(50),
              ),


            ],
          ),
        ));
  }
}
