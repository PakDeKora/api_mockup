import 'package:coin_gecko/app/config/color_config.dart';
import 'package:coin_gecko/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  Flavor.prod();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorConfig.primaryColor,
    ),
  );
  runApp(
    GetMaterialApp(
      title: "Coin Gecko",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorConfig.primaryColor,
          secondary: ColorConfig.primaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorConfig.primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
