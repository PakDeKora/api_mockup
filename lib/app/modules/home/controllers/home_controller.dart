import 'dart:convert';
import 'dart:developer';
import 'package:coin_gecko/app/models/coin_list_response.dart';
import 'package:coin_gecko/app/models/detail_coin_response.dart';
import 'package:coin_gecko/app/modules/home/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeService homeService = HomeService();

  Rx<bool> isLoading = false.obs;

  RxList<CoinListResponse> coinListData = <CoinListResponse>[].obs;
  Rx<DetailCoinResponse> detailCoinData = DetailCoinResponse().obs;

  Future<bool> coinList() async {
    isLoading.value = true;
    try {
      var list = await homeService.coinList();
      for (var element in list) {
        var data = CoinListResponse.fromJson(element);
        coinListData.add(data);
        // log(json.encode(data).toString(), name: 'Coin List Response');
      }
      isLoading.value = false;
      return true;
    } catch (e, stacktrace) {
      log("error: $e, in line $stacktrace", name: "Error Coin List Controller");
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> detailCoin({required id}) async {
    isLoading.value = true;
    try {
      DetailCoinResponse response = DetailCoinResponse.fromJson(await homeService.detailCoin(id: id));
      if (response.id != null) {
        detailCoinData.value = response;
        isLoading.value = false;
      }
      return true;
    } catch (e, stacktrace) {
      log("error: $e, in line $stacktrace");
      isLoading.value = false;
      return false;
    }
  }
}
