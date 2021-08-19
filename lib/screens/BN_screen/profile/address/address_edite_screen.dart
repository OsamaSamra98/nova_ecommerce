import 'package:flutter/material.dart';
import 'package:nova_ecommerce/getx/address_getx_controller.dart';
import 'package:nova_ecommerce/models/address_details.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/helper.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressDetails address;

  EditAddressScreen({required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController infoEditingController;
  late TextEditingController contactNumberEditingController;

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController(text: widget.address.name);
    infoEditingController = TextEditingController(text: widget.address.info);
    contactNumberEditingController =
        TextEditingController(text: widget.address.contactNumber);
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
          text: 'Edit Address',
          color: AppColors.Orange_COLOR,
          fontsize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30),vertical: SizeConfig.scaleHeight(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.scaleHeight(50),),
            AppText(text: 'Phone Number',color: Colors.grey,),
            app_textfield(
              controller: contactNumberEditingController,
              title: 'Phone Number',
              textInputType: TextInputType.phone,toppadding: 10,
            ),
            SizedBox(height: SizeConfig.scaleHeight(30),),
            AppText(text: 'Name',color: Colors.grey,),
            app_textfield(
              controller: nameEditingController,
              title: 'Name',toppadding: 10,
            ),
            SizedBox(height: SizeConfig.scaleHeight(30),),
            AppText(text: 'Info',color: Colors.grey,),
            app_textfield(
              controller: infoEditingController,
              title: 'info',toppadding: 10,
            ),
            SizedBox(height: SizeConfig.scaleHeight(40),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    await performEdit();
                  },
                  child: AppText(
                    text: 'Edit',
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
            ),

            SizedBox(
              height: 170,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performEdit() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (nameEditingController.text.isNotEmpty &&
        infoEditingController.text.isNotEmpty &&
        contactNumberEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> save() async {
    AddressDetails address = AddressDetails();
    address.id = widget.address.id;
    address.name = nameEditingController.text;
    address.contactNumber = contactNumberEditingController.text;
    address.info = infoEditingController.text;
    address.cityId = SharedPreferencesController().user!.cityId;
    bool status = await AddressGetxController.to.updateAddress(context: context, address: address);
    if (status) {
      Navigator.pop(context);
    } else {
      Helper.showSnackBar(context, text: 'error', error: true);
    }
  }
}
