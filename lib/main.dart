import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/firebase/fb_notifications.dart';
import 'package:nova_ecommerce/language/app_locale.dart';
import 'package:nova_ecommerce/screens/BN_screen/cart_screen.dart';
import 'package:nova_ecommerce/screens/launch_screen.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';

import 'db/db_provider.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider().initDatabase();

  await SharedPreferencesController().initSharedPreference();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: Locale(SharedPreferencesController().languageCode),
      translations: AppLocale(), // your translations

      home: launch_screen(),
        debugShowCheckedModeBanner: false ,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: AppColors.black_COLOR),
              backwardsCompatibility: true,
            )),
      routes: {

        '/cart_screen': (context) => cart_screen(),

      },
    );
  }
}
