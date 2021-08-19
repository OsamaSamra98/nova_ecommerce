
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nova_ecommerce/api/helper/api_mixin.dart';
import 'package:nova_ecommerce/mixins/helpers.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';

import '../api_settings.dart';

class RatingApiController with ApiMixin, Helpers {
  Future<bool> rate(BuildContext context,
      {required int product_id, required num rate}) async {
    var response = await http.post(getUrl(ApiSettings.RATE),
        body: {'product_id': product_id.toString(), 'rate': rate.toString()},headers: {
        HttpHeaders.authorizationHeader:'Bearer '+SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'lang': 'en'
        });

    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }else{
      handleServerError(context);
    }
    return false;
  }
}