import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:nova_ecommerce/getx/card_getx_controller.dart';
import 'package:nova_ecommerce/models/card.dart';
import 'package:nova_ecommerce/screens/BN_screen/profile/create_credit_card.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/my_card_widget.dart';

class DisplayCardScreen extends StatelessWidget {
  CardGetxController controller = Get.put(CardGetxController());
  final bool fromOrder;

  DisplayCardScreen({this.fromOrder = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetX<CardGetxController>(
        builder: (CardGetxController controller) {
          return controller.loading.value
              ? Center(child:GradientProgressIndicator(
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
          ),
          )
              : controller.cards.isNotEmpty
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 29, vertical: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.cards.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // return AddressWidget(
                          //   address: controller.addresses[index],
                          // );
                          return GestureDetector(
                            onTap: () {
                              popScreen(card: controller.cards[index]);
                            },
                            child: MyCardWidget(
                              expiryDate: controller.cards[index].expDate,
                              cvvCode: controller.cards[index].cvv.toString(),
                              flag: false,
                              cardHolderName:
                                  controller.cards[index].holderName,
                              cardNumber: controller.cards[index].cardNumber,
                              cardType: controller.cards[index].type == 'Visa'
                                  ? CardType.visa
                                  : CardType.mastercard,
                            ),
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
        onPressed: () {
          Get.to(CreateCreditCard());
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.Orange_COLOR,
      ),
    );
  }

  popScreen({required MyCard card}) {
    print(fromOrder);
    if (fromOrder) Get.back(result: card);
  }
}
