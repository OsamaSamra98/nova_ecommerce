import 'package:flutter/material.dart';
import 'package:nova_ecommerce/firebase/fb_notifications.dart';
import 'package:nova_ecommerce/screens/BN_screen/FavoriteProductsScreen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';

import '../../utils/bn_screen.dart';
import 'cart_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';

class main_Screen extends StatefulWidget {
  @override
  _main_ScreenState createState() => _main_ScreenState();
}

class _main_ScreenState extends State<main_Screen> with FbNotifications {
  int _selectedItemIndex = 0;
  String _title = 'Home';

  List<BottomNavigationScreen> _screens = <BottomNavigationScreen>[
    BottomNavigationScreen(title: ('Home'), widget: home_screen()),
    BottomNavigationScreen(
        title: ('FavoriteProducts'), widget: FavoriteProductsScreen()),
    BottomNavigationScreen(title: ('cart'), widget: cart_screen()),
    BottomNavigationScreen(title: ('profile'), widget: profile_screen()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black_COLOR,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.Orange_COLOR,

        currentIndex: _selectedItemIndex,
        onTap: (int selectedItemIndex) {
          setState(() {
            _selectedItemIndex = selectedItemIndex;
          });
        },
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: _screens
          .elementAt(_selectedItemIndex)
          .widget,
    );
  }
}
