import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/notification_getx_controller.dart';
import 'package:nova_ecommerce/utils/SizeConfig.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          text: 'Notification'.tr,
          fontsize: SizeConfig.scaleTextFont(24),
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),
        child: GetX<NotificationGetxController>(
          builder: (NotificationGetxController controller) {
            return controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : controller.notification.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.notification.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return NotificationWidget(
                                  notificationDetails:
                                      controller.notification[index],
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                text: 'There is no Notification yet'.tr,
                                fontsize: SizeConfig.scaleTextFont(26),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                              ),
                            ]),
                      );
          },
        ),
      ),
    );
  }
}
