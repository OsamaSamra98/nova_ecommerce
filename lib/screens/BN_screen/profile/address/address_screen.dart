import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/address_getx_controller.dart';
import 'package:nova_ecommerce/models/address_details.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/address/add_address_screen.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/address_widget.dart';
import 'package:nova_ecommerce/utils/app_text.dart';


class AddressScreen extends StatelessWidget {
  AddressGetxController controller = Get.put(AddressGetxController());
  final bool fromOrder;
  AddressScreen({this.fromOrder = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetX<AddressGetxController> (
        builder: (AddressGetxController controller){
          return controller.loading.value
              ? Center(child: GradientProgressIndicator(
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
                  text: 'loading',
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ))
              : controller.addresses.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.addresses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AddressWidget(
                  address: controller.addresses[index],
                  onTap: () => popScreen(address: controller.addresses[index]),
                );
              },
            ),
          )
              : Center(
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
                    text: 'There is no product yet ',
                    fontsize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.Orange_COLOR,
        onPressed: (){
          Get.to(AddAddressScreen());
        },
        child: Icon(Icons.add,),
      ),
    );
  }
  popScreen({required AddressDetails address}) {
    if (fromOrder) Get.back(result: address);
  }
}
