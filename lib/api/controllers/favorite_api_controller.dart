
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nova_ecommerce/api/helper/api_mixin.dart';
import 'package:nova_ecommerce/mixins/helpers.dart';
import 'package:nova_ecommerce/models/product.dart';
import 'package:nova_ecommerce/shared_preferences/preferences.dart';

import '../api_settings.dart';

class FavoriteApiController with ApiMixin, Helpers {
  Future<bool> addFavorite(BuildContext context,
      {required int product_id}) async {
    var response = await http.post(getUrl(ApiSettings.ADD_FAVARITE_PRODUCT),
      body: {'product_id': product_id.toString()},headers: {
        HttpHeaders.authorizationHeader:'Bearer '+ SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
      },);
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
  Future<List<Product>> getProduct() async {
    var url = Uri.parse(ApiSettings.READ_FAVARITE_PRODUCT);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+ SharedPreferencesController().token,
      'Accept': 'application/json'
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Product> product = data.map((e) => Product.fromJson(e)).toList();
      return product;
    }
    return [];
  }

}