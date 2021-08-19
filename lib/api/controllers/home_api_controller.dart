import 'dart:convert';
import 'dart:developer';
import 'package:nova_ecommerce/api/helper/api_mixin.dart';
import 'package:nova_ecommerce/models/Home.dart';

import '../api_settings.dart';
import 'package:http/http.dart' as http;

class HomeApiController with ApiMixin {

  Future<HomeModel?>  getHome() async {
    var response = await http.get(getUrl(ApiSettings.HOME),headers:header);
    log('get home api=> ${response.body}');
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      HomeModel model =HomeModel.fromJson(data);
      log('return');
      return model;
    }else{
      return null;
    }
  }
}