
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/screens/Auth/login/login_Screen.dart';
import 'package:nova_ecommerce/screens/on_boarding/on_boarding_content.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
// TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            right: SizeConfig.scaleWidth(16), left: SizeConfig.scaleWidth(16)),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int selectedPage) {
                setState(() {
                  _currentPage = selectedPage;
                });
              },
              children: [
                OnBoardingContent(
                  image: 'images/OnboardingScreen 3.svg',
                  title: 'Discover a New For You',
                  sub_title: 'Lots of new products, decide which product is best for you',
                ),
                OnBoardingContent(
                  image: 'images/OnboardingScreen 2.svg',
                  title: 'Find Your Best Product',
                  sub_title: 'Famous and quality product at affordable prices',
                ),
                OnBoardingContent(
                  image: 'images/OnboardingScreen 3.svg',
                  title: 'Express Product Delivery',
                  sub_title: 'Your product will be delivered to your home safetly ',
                ),
              ],
            ),
            Positioned(
              bottom: SizeConfig.scaleHeight(142),
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: ExpandingDotsEffect(
                            spacing: 4.0,
                            radius: 4.0,
                            dotWidth: 10.0,
                            dotHeight: 8.0,
                            strokeWidth: 1.5,
                            expansionFactor: 3,
                            dotColor: AppColors.darkGRAY_COLOR,
                            activeDotColor: AppColors.Orange_COLOR),
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(15),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
                bottom: SizeConfig.scaleHeight(14),
                left: 0,
                right: 0,
                child:ElevatedButton(
                  onPressed: () {
                    Get.off(login_Screen());
                  },
                  child: Text('Getting Start'),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.Orange_COLOR,
                      minimumSize: Size(double.infinity, 64),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                ) )
          ],
        ),
      ),
    );
  }
}
