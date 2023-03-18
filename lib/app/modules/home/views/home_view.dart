import 'dart:developer';
import 'package:coin_gecko/app/config/color_config.dart';
import 'package:coin_gecko/app/helpers/dynamic_field/simple_text.dart';
import 'package:coin_gecko/app/helpers/helper.dart';
import 'package:coin_gecko/app/modules/home/controllers/home_controller.dart';
import 'package:coin_gecko/app/modules/home/views/detail_coin_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  final percentageFormat = intl.NumberFormat("##0.0#");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        try {
          homeController = Get.find<HomeController>();
        } catch (e) {
          homeController = Get.put(HomeController());
        }
        homeController.onStart();
        await homeController.coinList();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: homeController.coinListData.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await homeController.detailCoin(id: homeController.coinListData.value.elementAt(index).id.toString());
                        Get.to(() => DetailCoinView(
                              id: homeController.coinListData.value.elementAt(index).id.toString(),
                            ));

                        log(homeController.coinListData.value.elementAt(index).id.toString());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: Helper.getRadius(6.0, isAll: true),
                          // color: ColorConfig.primaryColor,
                          border: Border.all(color: ColorConfig.primaryColor, width: 2),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.network("${homeController.coinListData.value.elementAt(index).image}"),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextHelper.titleText(text: homeController.coinListData.value.elementAt(index).name),
                                      TextHelper.subTitleText(
                                        text: Helper.getCurrency(homeController.coinListData.value.elementAt(index).priceChange24h!).toString(),
                                      ),
                                    ],
                                  ),
                                  TextHelper.titleText(
                                    text: "${percentageFormat.format(homeController.coinListData.value.elementAt(index).priceChangePercentage24h)}%",
                                    color: homeController.coinListData.value.elementAt(index).priceChangePercentage24h.toString().contains('-')
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
