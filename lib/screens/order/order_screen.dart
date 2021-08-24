import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/cart_getx_controller.dart';
import 'package:nova_ecommerce/getx/order_getx_controller.dart';
import 'package:nova_ecommerce/models/address_details.dart';
import 'package:nova_ecommerce/models/card.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/address/address_screen.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/crediteCard.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/helper.dart';


class OrderScreen extends StatefulWidget {
  final String cart;

  OrderScreen({required this.cart});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isOnline = true;
  AddressDetails? address;
  MyCard? card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppText(
          text: 'Make Order'.tr,
          color: AppColors.Orange_COLOR,
          fontsize: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          GestureDetector(
            onTap: () async {
              AddressDetails selectedAddress = await Get.to(AddressScreen(
                fromOrder: true,
              ));
              setState(() {
                address = selectedAddress;
              });
            },
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 28, end: 10),
              alignment: AlignmentDirectional.centerStart,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF999999).withAlpha(25),
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  getAddress(),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: AppColors.Orange_COLOR,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              MyCard selectedCard = await Get.to(DisplayCardScreen(fromOrder: true,));
              setState(() {
                card = selectedCard;
              });
            },
            child: Container(
                padding: EdgeInsetsDirectional.only(start: 28, end: 10),
                alignment: AlignmentDirectional.centerStart,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF999999).withAlpha(25),
                        offset: Offset(0, 5),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    getCard(),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.Orange_COLOR,
                    )
                  ],
                )),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.Orange_COLOR,
                  value: isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = true;
                    });
                  },
                  title: AppText(
                    text: 'online'.tr,
                    fontsize: 16,
                    color: AppColors.Orange_COLOR,
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.red,
                width: 50,
                thickness: 5,
              ),
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.Orange_COLOR,
                  value: !isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = false;
                    });
                  },
                  title: AppText(
                    text: 'offline'.tr,
                    fontsize: 16,
                    color: AppColors.Orange_COLOR,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 42),
          SizedBox(
            width: 230,
            child: ElevatedButton(
                  onPressed: () async => await performOrder(),
              child: AppText(
                text: 'Confirm Order'.tr,
                color: AppColors.background_COLOR,
                fontsize: 20,
                fontWeight: FontWeight.bold,
              ),
              style: ElevatedButton.styleFrom(
                  primary: AppColors.Orange_COLOR,
                  minimumSize: Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),

        ],
      ),
    );
  }

  Widget getCard() {
    if (card == null) {
      return AppText(
        text: 'selectCard'.tr,
        color: Colors.grey,
      );
    } else {
      return AppText(
        text: card!.cardNumber,
        color: AppColors.Orange_COLOR,
        fontsize: 16,
      );
    }
  }

  Widget getAddress() {
    if (address == null) {
      return AppText(
        text: 'selectAddress'.tr,
        color: Colors.grey,
      );
    } else {
      return AppText(
        text: address!.info,
        color: AppColors.Orange_COLOR,
        fontsize: 16,
      );
    }
  }

  Future<void> performOrder() async {
    if (checkData())
      await makeOrder();
    else
      Helper.showSnackBar(context, text: 'Enter Required Data'.tr);
  }

  bool checkData() {
    if (card != null && address != null) return true;
    return false;
  }

  Future<void> makeOrder() async {
    bool status = await OrderGetxController.to.createOrder(
        context: context,
        cart: widget.cart,
        paymentType: isOnline ? 'Online' : 'Offline',
        addressId: address!.id,
        cardId: card!.id);
    if (status) {
      await CartGetxController.to.deleteAllItem();
      Get.back();
    }
  }
}


