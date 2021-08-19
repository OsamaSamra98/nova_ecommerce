import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/api/controllers/home_api_controller.dart';
import 'package:nova_ecommerce/models/Home.dart';

class HomeGetxController extends GetxController {
  final HomeApiController homeApiController = HomeApiController();
  //RxList<Category> categories = <Category>[].obs;
  HomeModel? homeModel;


  static HomeApiController get to => Get.find();

  void onInit() {
    getHome();
    super.onInit();
  }

  Future<void> getHome() async {
    HomeModel? model = await homeApiController.getHome();
    this.homeModel = model;
    log('homeApiController');
    log(model!.message);
    update();

  }



}
