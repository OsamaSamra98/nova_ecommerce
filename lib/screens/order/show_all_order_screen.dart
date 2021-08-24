import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:nova_ecommerce/getx/order_getx_controller.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/order_widget.dart';

class ShowAllOrdersScreen extends StatefulWidget {
  @override
  _ShowAllOrdersScreenState createState() => _ShowAllOrdersScreenState();
}

class _ShowAllOrdersScreenState extends State<ShowAllOrdersScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await OrderGetxController.to.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Purchases ',
              style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.scaleTextFont(20),
                  color: AppColors.black_COLOR),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            Container(
              child: GetX<OrderGetxController>(
                builder: (OrderGetxController controller) {
                  return controller.loading.value
                      ? Center(child: CircularProgressIndicator())
                      : controller.orders.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.orders.length,
                              shrinkWrap: true,reverse: true,
                              itemBuilder: (context, index) {
                                return OrderWidget(
                                  order: controller.orders[index],
                                );
                              },
                            )
                          : Center(child: Text('No Data'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
