import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/cart_getx_controller.dart';
import 'package:nova_ecommerce/models/cart_item.dart';
import 'package:nova_ecommerce/screens/order/order_screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/category_card.dart';
import 'package:nova_ecommerce/utils/helper.dart';
import 'package:nova_ecommerce/utils/Cart_widget.dart';
class cart_screen extends StatefulWidget {
  @override
  _cart_screenState createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  CartGetxController controller = Get.put(CartGetxController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AppText(text: 'MY Cart'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30)),
            child: Column(
              children: [
                GetX<CartGetxController>(
                  builder: (CartGetxController controller) {
                    return controller.loading.value
                        ? Center(
                            child: GradientProgressIndicator(
                            radius: 100,
                            duration: 3,
                            strokeWidth: 12,
                            gradientStops: const [
                              0.2,
                              0.8,
                            ],
                            gradientColors: const [
                              Colors.orange,
                              Colors.orangeAccent,
                            ],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: 'Loading',
                                  fontsize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ))
                        : controller.cartItem.isNotEmpty
                            ? SizedBox(
                                width: SizeConfig.scaleWidth(400),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: controller.cartItem.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.25,
                                          actions: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.scaleWidth(10),
                                                  top: SizeConfig.scaleHeight(
                                                      10)),
                                              child: Container(
                                                  width: 25,
                                                  height: 105,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .background_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      await deleteItem(
                                                          cartItem: controller
                                                              .cartItem[index],
                                                          context: context);
                                                    },
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.red,
                                                  )),
                                            )
                                          ],
                                          child: Cart_widget(
                                            cartItem:
                                                controller.cartItem[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                  ),
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 150,
                                    color: Colors.grey.shade800,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  AppText(
                                    text: ' YOUR CART IS EMPTY ',
                                    color: AppColors.Orange_COLOR,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 20,
                                    letterSpacing: 1,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  AppText(
                                    text:
                                        'Look like you haven\'t made your choice yet',
                                    color: Colors.grey.shade800,
                                    fontsize: 16,
                                    letterSpacing: 1,
                                  ),
                                ],
                              ));
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.scaleHeight(15),
            horizontal: SizeConfig.scaleWidth(30),
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(OrderScreen(
                      cart: cart,
                    ));
                  },
                  child: AppText(
                    text: 'Check Out',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteItem(
      {required CartItem cartItem, required BuildContext context}) async {
    bool status = await CartGetxController.to.deleteItem(cartItem.id);
    String msg = status ? 'delete success' : 'delete fail';
    Helper.showSnackBar(context, text: msg);
  }

  String get cart {
    List<Map<String, dynamic>> items = [];
    CartGetxController.to.cartItem
        .map((element) => items.add({
              'product_id': element.productId,
              'quantity': element.quantity,
              'price': element.price
            }))
        .toList();
    return jsonEncode(items);
  }
}
