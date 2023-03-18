// ignore_for_file: must_be_immutable

import 'package:coin_gecko/app/helpers/dynamic_field/progress_bar.dart';
import 'package:coin_gecko/app/helpers/dynamic_field/simple_text.dart';
import 'package:coin_gecko/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DetailCoinView extends StatefulWidget {
  String id;
  DetailCoinView({super.key, required this.id});

  @override
  State<DetailCoinView> createState() => _DetailCoinViewState();
}

class _DetailCoinViewState extends State<DetailCoinView> {
  HomeController homeController = Get.put(HomeController());

  final formatter = intl.NumberFormat("#,##0.0######"); // for price change
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
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: homeController.isLoading.value,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.5),
        progressIndicator: ProgressBar(),
        child: Scaffold(
          appBar: AppBar(
            title: TextHelper.titleText(text: "${homeController.detailCoinData.value.name}", color: Colors.white),
          ),
          body: Container(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffb3c6ff), //opacity,hex
                      Color(0xFFCECECE),
                    ],
                    begin: FractionalOffset(0.0, 1.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  height: 700,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network("${homeController.detailCoinData.value.image!.large}"),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "${homeController.detailCoinData.value.name}",
                                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  // height: 30,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("# ${homeController.detailCoinData.value.marketCapRank}",
                                          style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${homeController.detailCoinData.value.marketData!.currentPrice!.usd}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 6),
                                  (homeController.detailCoinData.value.marketData!.priceChangePercentage24h! > 0)
                                      ? Row(
                                          children: [
                                            Icon(Icons.arrow_drop_up_sharp, color: Colors.green[600]),
                                            Text(
                                              "(${homeController.detailCoinData.value.marketData!.priceChangePercentage24h}%)",
                                              style: TextStyle(fontSize: 16, color: Colors.green[700]),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            const Icon(Icons.arrow_drop_down_sharp, color: Colors.red),
                                            Text("(${homeController.detailCoinData.value.marketData!.priceChangePercentage24h!}%)",
                                                style: const TextStyle(fontSize: 16, color: Colors.red)),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: (homeController.detailCoinData.value.marketData!.priceChange24h! > 0)
                                  ? Text(
                                      (homeController.detailCoinData.value.marketData!.currentPrice!.usd! < 2)
                                          ? "+${formatter.format(homeController.detailCoinData.value.marketData!.currentPrice!.usd!)}"
                                          : "+${percentageFormat.format(homeController.detailCoinData.value.marketData!.currentPrice!.usd!)}",
                                      style: TextStyle(color: Colors.green[700]),
                                    )
                                  : Text(
                                      (homeController.detailCoinData.value.marketData!.currentPrice!.usd! < 2)
                                          ? formatter.format(homeController.detailCoinData.value.marketData!.currentPrice!.usd!)
                                          : percentageFormat.format(homeController.detailCoinData.value.marketData!.currentPrice!.usd!),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(color: Colors.white54, thickness: 2),
                            const SizedBox(height: 10),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 320,
                                    child: SingleChildScrollView(
                                      child: Text("${homeController.detailCoinData.value.description!.en}"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
