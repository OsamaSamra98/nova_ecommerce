

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:nova_ecommerce/api/api_settings.dart';
import 'package:nova_ecommerce/api/helper/api_mixin.dart';
import 'package:nova_ecommerce/models/notification.dart';

class NotificationApiController with ApiMixin{
  Future<List<NotificationDetails>> getAllNotification() async {
    var response = await http.get(getUrl(ApiSettings.NOTIFICATION), headers: headerNotification);

    log('get notification api=> ${response.statusCode}');
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<NotificationDetails> notifications = data.map((e) => NotificationDetails.fromJson(e)).toList();
      return notifications;
    }
    return [];
  }
}