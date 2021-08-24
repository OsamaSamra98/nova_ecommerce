import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/address_getx_controller.dart';
import 'package:nova_ecommerce/models/address.dart';
import 'package:nova_ecommerce/models/address_details.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}



class _AddAddressScreenState extends State<AddAddressScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController infoEditingController;
  late TextEditingController contactNumberEditingController;


  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController();
    infoEditingController = TextEditingController();
    contactNumberEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    infoEditingController.dispose();
    contactNumberEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppText(
          text: 'Add Address'.tr,
          color: AppColors.Orange_COLOR,
          fontsize: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          SizedBox(height: 30),

          app_textfield(
            controller: contactNumberEditingController,
            title: 'Phone Number',
            textInputType: TextInputType.phone,
          ),
          app_textfield(
            controller: nameEditingController,
            title: 'Name'.tr,
          ),
          app_textfield(
            controller: infoEditingController,
            title: 'info'.tr,
          ),
          SizedBox(height: 42),
          ElevatedButton(
            onPressed: () async {
              await performAdd();
            },
            child: AppText(
              text: 'Add'.tr,
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
            height: 170,
          ),
        ],
      ),
    );
  }

  Future<void> performAdd() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (
    nameEditingController.text.isNotEmpty &&
        infoEditingController.text.isNotEmpty &&
        contactNumberEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> save() async {
    AddressDetails address = AddressDetails();
    address.name = nameEditingController.text;
    address.contactNumber = contactNumberEditingController.text;
    address.info = infoEditingController.text;
    address.cityId = SharedPreferencesController().user!.cityId;

    bool status = await AddressGetxController.to.createAddress(
        context: context,
        address: address
    );
    if (status) {
      Navigator.pop(context);
    } else {
      Helper.showSnackBar(context, text: 'error', error: true);
    }
  }
}
