import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/drawerlistTile.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        UserAccountsDrawerHeader(
          accountName: AppText(text: 'Osama Abo Samra',fontsize: 18,color: AppColors.black_COLOR,fontWeight: FontWeight.bold,),
          accountEmail: Text(""),
          currentAccountPicture: Image.asset('images/profile.png',),
          decoration: BoxDecoration(color: AppColors.background_COLOR),
        ),
        drawerlistTile(title: 'HOME', ontap: () {Navigator.pushNamed(context, '/home_screen');}),
        drawerlistTile(title: 'My Wallet', ontap: () {Navigator.pushNamed(context, '/My Wallet');}),
        drawerlistTile(title: 'Category', ontap: () {Navigator.pushNamed(context, '/categories_screen');}),
        drawerlistTile(title: 'My Likes', ontap: () {Navigator.pushNamed(context, '/favoriteProduct_screen');}),
        SizedBox(height: SizeConfig.scaleHeight(80),),
        drawerlistTile(title: 'Contact Us ',ontap: () {Navigator.pushNamed(context, '/home');}),
        drawerlistTile(title: 'About', ontap: () {Navigator.pushNamed(context, '/about_Screen');}),
        drawerlistTile(title: 'Help', ontap: () {Navigator.pushNamed(context, '/home');}),
        drawerlistTile(title: 'Logout', ontap: () {Navigator.pushNamed(context, '/home');}),
      ]),
    );
  }
}
