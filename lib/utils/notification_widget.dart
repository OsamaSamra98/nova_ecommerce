import 'package:flutter/material.dart';
import 'package:nova_ecommerce/models/notification.dart';

import 'SizeConfig.dart';
import 'app_text.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationDetails notificationDetails;
  final void Function() onTap;

  NotificationWidget({
    required this.notificationDetails,
    required this.onTap,
  });

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.scaleHeight(5)),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.notificationDetails.title}', style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(16),
                      fontWeight: FontWeight.w500,
                      color: Colors.black,),),

                    Spacer(),
                    Text(
                      '${widget.notificationDetails.sentAt}', style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.black,),),

                  ],
                ),
                Text(
                  '${widget.notificationDetails.subtitle}', style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(15),
                  fontWeight: FontWeight.w500,
                  color: Color(0xff9E9E9E)),),

              ],
            ),
          ),
          subtitle:Text(
            '${widget.notificationDetails.body}', style: TextStyle(
            fontSize: SizeConfig.scaleTextFont(15),
            fontWeight: FontWeight.w400,
            color: Color(0xff9E9E9E)),),
        ),
      ),
    );
  }
}
