import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nova_ecommerce/models/cart_item.dart';

import 'AppColors.dart';
import 'SizeConfig.dart';
import 'app_text.dart';

class Cart_widget extends StatefulWidget {
  final CartItem cartItem;

  Cart_widget({
    required this.cartItem,
  });

  @override
  _Cart_widgetState createState() => _Cart_widgetState();
}

class _Cart_widgetState extends State<Cart_widget> {
  int cardIncrement = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.scaleHeight(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: SizeConfig.scaleWidth(80),
                height: SizeConfig.scaleHeight(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.darkGRAY_COLOR,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      child: Image.network(widget.cartItem.imageUrl,
                          height: 150, width: 120, fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: '${widget.cartItem.nameEn}',
                  fontsize: 14,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: 'Price : ${widget.cartItem.price}  \$ ',
                  fontsize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_COLOR,
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text:
                      'Total Price : ${widget.cartItem.price * widget.cartItem.quantity} ' + '\$',
                  fontsize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.Orange_COLOR,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.scaleWidth(10),
                  top: SizeConfig.scaleHeight(10)),
              child: Container(
                width: SizeConfig.scaleWidth(50),
                height: SizeConfig.scaleHeight(105),
                decoration: BoxDecoration(
                    color: AppColors.background_COLOR,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            cardIncrement++;
                            widget.cartItem.quantity = cardIncrement;
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.Orange_COLOR,
                        )),
                    SizedBox(
                      height: SizeConfig.scaleHeight(8),
                    ),
                    AppText(text: widget.cartItem.quantity.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cardIncrement == 1 ? 1 : --cardIncrement;
                          widget.cartItem.quantity = cardIncrement;
                        });
                      },
                      icon: Icon(
                        Icons.minimize,
                        color: AppColors.Orange_COLOR,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(20),
            )
          ],
        ),
      ),
    );
  }
}
