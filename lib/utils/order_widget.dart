import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/models/order.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';


import 'AppColors.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  OrderWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Order ID ${order.id}',style: TextStyle(fontSize:SizeConfig.scaleTextFont(13),fontWeight: FontWeight.w500, fontFamily: 'NunitoSans'),),
              SizedBox(height: SizeConfig.scaleHeight(5)),
              Text('Total Price: ${order.total}',style: TextStyle(fontSize:SizeConfig.scaleTextFont(12),fontWeight: FontWeight.w500,color: AppColors.Orange_COLOR,fontFamily: 'NunitoSans'),),

            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: order.status == 'Waiting' ? Colors.red : Colors.green),
            child: Text('${order.status}',style: TextStyle(fontSize:SizeConfig.scaleTextFont(13),fontWeight: FontWeight.w500, fontFamily: 'NunitoSans'),),

          )
        ],
      ),
    );
  }
}
