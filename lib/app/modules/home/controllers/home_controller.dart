import 'package:april_store/app/model/produk_model.dart';
import 'package:april_store/app/services/all_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AllServices allServices = AllServices();
  final int limit = 10;
  int skip = 0;
  var hasMore = true.obs;
  var produk = <Products>[].obs;
  TextEditingController SearchController = TextEditingController();
  var cari = <Products>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future searchProduk() async {
    try {
      List<Products> response =
          await allServices.searchProduk(SearchController.text);
      cari.value = [];
      cari.addAll(response);
      update();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future getProduk() async {
    try {
      List<Products> response = await allServices.getProduk(limit, skip);
      if (response.length < limit) {
        hasMore.value = false;
      }

      produk.addAll(response);
      skip += 10;
      update();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refreshData() async {
    skip = 0;
    hasMore.value = true;
    produk.value = [];

    await getProduk();
  }
}
