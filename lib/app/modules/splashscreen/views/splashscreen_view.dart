import 'package:coin_gecko/app/helpers/dynamic_field/progress_bar.dart';
import 'package:coin_gecko/app/modules/home/controllers/home_controller.dart';
import 'package:coin_gecko/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({super.key});

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  HomeController homeController = Get.put(HomeController());

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
        Future.delayed(const Duration(seconds: 2)).then((_) {
          Get.offAll(() => const HomeView());
        });
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SplashScreen",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 12),
              ProgressBar(),
            ],
          ),
        ),
      ),
    );
  }
}
