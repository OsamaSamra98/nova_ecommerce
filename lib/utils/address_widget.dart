import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/address_getx_controller.dart';
import 'package:nova_ecommerce/models/address_details.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/address/address_edite_screen.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';

import 'AppColors.dart';
import 'app_text.dart';

class AddressWidget extends StatelessWidget {
  final AddressDetails address;
  final void Function() onTap;

  AddressWidget({required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsetsDirectional.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 8,
                end: 8,
                top: 8,
                bottom: 8,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 30,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red.shade900,
                  size: 30,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: address.info,
                  fontWeight: FontWeight.w500,
                  fontsize: 13,
                ),
                SizedBox(height: SizeConfig.scaleHeight(15)),
                AppText(
                  text: '0' + address.contactNumber,
                  fontWeight: FontWeight.w500,
                  fontsize: 12,
                  color: AppColors.Orange_COLOR,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async => await performDialog(context),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              color: AppColors.Orange_COLOR,
              child: IconButton(
                onPressed: () => Get.to(EditAddressScreen(address: address)),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> deleteAddressDialog({required BuildContext context}) async {
    bool status = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: AppText(
              text: 'Delete Address',
              textAlign: TextAlign.start,
            ),
            content: AppText(
              text: 'Are you sure you want to delete this Address?',
              textAlign: TextAlign.start,
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: AppText(text: 'No'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: AppText(text: 'Yes'),
              ),
            ],
          );
        });
    return status;
  }

  Future<void> performDialog(BuildContext context) async {
    bool status = await deleteAddressDialog(context: context);
    if (status) {
      await AddressGetxController.to
          .deleteAddress(context: context, addressId: address.id);
    }
  }
}
