
import 'package:flutter/material.dart';
import 'package:nova_ecommerce/models/city.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';

import 'app_text.dart';


class CityWidget extends StatelessWidget {
  final City city;
  final void Function() onTap;

  CityWidget({required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Text(SharedPreferencesController().languageCode == 'ar' ? city.nameAr: city.nameEn),
          ],
        ),
      ),
    );
  }
}
