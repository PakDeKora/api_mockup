import 'dart:developer';
import 'dart:io';

import 'package:coin_gecko/app/config/db_config.dart';
import 'package:coin_gecko/app/modules/splashscreen/views/splashscreen_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();

class ApiConfig {
  final String BASE_URL = FlavorConfig.instance.variables["baseUrl"];
  late SharedPreferences sp;

  int errorCount = 0;

  ApiConfig() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          if (e.type == DioErrorType.unknown) {
            if (Get.isDialogOpen != null && Get.isDialogOpen == false) {
              Get.defaultDialog(
                title: "No Internet Connection",
                middleText: "Please check your internet connection and try again.",
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(color: Colors.black, fontSize: 14),
                middleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
                titlePadding: const EdgeInsets.only(top: 24),
                contentPadding: const EdgeInsets.all(24),
              );
              return;
            }
            return handler.next(e);
          }
          return handler.next(e);
        },
      ),
    );
  }
}

class ServerHandleResponse {
  ServerHandleResponse._internal();
  static final ServerHandleResponse instance = ServerHandleResponse._internal();
  late int code;
  late BuildContext context;
  Map<String, dynamic>? errorData = {"success": false, "msg": ""};
  setContext(BuildContext context) {
    this.context = context;
  }

  Future serverResponseError(int responseCode, {Map<String, dynamic>? object, List<dynamic>? listObj, bool? isLogin = false, String? message}) async {
    int code = responseCode;
    dynamic result;
    List<dynamic> resultList = [];
    switch (code) {
      case 401:
        if (isLogin! == false) {
          alertUnAuth();
        } else {
          // alertError("[401] ${message??"Internal Server Error"}");
          errorData!['msg'] = "[401] ${message ?? "Internal Server Error"}";
          if (listObj != null) {
            result = resultList;
          } else {
            result = errorData;
          }
        }
        break;

      case 405:
        // alertError("[500] Internal Server Error");
        errorData!['msg'] = "[405] method is not supported for this route";
        errorData!['code'] = 405;
        result = errorData;
        break;

      case 500:
        // alertError("[500] Internal Server Error");
        errorData!['msg'] = "[500] Internal Server Error";
        errorData!['code'] = 500;
        if (listObj != null) {
          result = resultList;
        } else {
          result = errorData;
        }
        break;

      case 409:
        // alertError("[409] ${message??"Internal Server Error"}");
        errorData!['msg'] = "[409] ${message ?? "Internal Server Error"}";
        errorData!['code'] = 409;
        if (listObj != null) {
          result = resultList;
        } else {
          result = errorData;
        }
        break;

      case 404:
        // alertError("[404] Internal Server Error");
        errorData!['msg'] = "[404] Internal Server Error";
        errorData!['code'] = 404;
        if (listObj != null) {
          result = resultList;
        } else {
          result = errorData;
        }
        break;

      default:
        if (kDebugMode) {
          print("RETURN_OBJECT");
        }
        object?['code'] = 200;
        if (listObj != null) {
          result = listObj;
        } else {
          result = object;
        }
        break;
    }
    return result;
  }

  Future check(Function fun, Function errorFun) async {
    try {
      await fun();
    } on SocketException {
      log("Connection Error");
      errorFun();
    } on FormatException {
      log("Format Error");
      errorFun();
    } on Exception {
      log("Unexpected Error");
      errorFun();
    } catch (e) {
      log(e.toString());
      log("Catch Error");
      // showDialog();
      errorFun();
    }
  }

  void showDialog() {}
  void showDialogConnection(int code) {}
  void showDialogCustomContent({content}) {}
  void alertUnAuth() {
    Get.offAll(() => const SplashscreenView());
    Get.defaultDialog(
        title: "Peringatan",
        content: const Center(
          child: Text("Sesi anda telah berakhir, mohon untuk login kembali"),
        ));
  }
}

class ApiService {
  ///=== Don't edit this code===
  ///Convert data stream dio to object
  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    try {
      if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
        if (T == String) {
          requestOptions.responseType = ResponseType.plain;
        } else {
          requestOptions.responseType = ResponseType.json;
        }
      }
    } catch (e, stacktrace) {
      log("error $e, stacktrace line: $stacktrace");
    }
    return requestOptions;
  }

  ///=== Don't edit this code===
  ///Handle data request
  Future<dynamic> dataRequest<T>({
    required String method,
    required String url,
    dynamic map,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool isUnAuth = false,
    bool isArray = false,
  }) async {
    var result;
    try {
      if (isArray == true) {
        result = await dio.fetch<List<dynamic>>(_setStreamType<T>(
            Options(method: method, headers: header).compose(dio.options, url, data: map, queryParameters: query).copyWith(baseUrl: ApiConfig().BASE_URL)));
      } else {
        result = await dio.fetch<Map<String, dynamic>>(_setStreamType<T>(
            Options(method: method, headers: header).compose(dio.options, url, data: map, queryParameters: query).copyWith(baseUrl: ApiConfig().BASE_URL)));
      }

      ///logger data
      log(ApiConfig().BASE_URL + url, name: "endpoint");
      log(result.data.toString(), name: "payload");

      // log(url);
      if (isArray == true) {
        return ServerHandleResponse.instance.serverResponseError(200, isLogin: isUnAuth, listObj: result.data);
      } else {
        return ServerHandleResponse.instance.serverResponseError(200, isLogin: isUnAuth, object: result.data);
      }
    } on DioError catch (onError) {
      final res = (onError).response;

      ///logger error
      log(ApiConfig().BASE_URL + url, name: "endpoint");
      log(onError.message!);
      log("${res?.data}");
      log("${res?.statusCode ?? 0}");

      // if (res?.statusCode == 413) {
      //   Helper.of(NavigationService.navigatorKey.currentContext!).alertCustom("Ukuran foto logam maksimal 3 MB");
      // }

      if (isArray == true) {
        return ServerHandleResponse.instance.serverResponseError(404, listObj: null, isLogin: isUnAuth, message: "page not found");
      }
      return ServerHandleResponse.instance.serverResponseError(404, object: {}, isLogin: isUnAuth, message: "page not found");
    }
  }
}

class NetworkConfiguration {
  final DbConfig _dbService = DbConfig();

  Map<String, dynamic>? dioWithoutAuth() {
    final dio = Dio();
    dio.options.headers["Accept"] = "application/json"; // config your dio headers globally // config your dio headers globally
    // dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 3000);
    // log(PreferenceUtils.getString(Constants.token));
    return dio.options.headers;
  }

  Future<Map<String, dynamic>?> dioAuth() async {
    var token = await _dbService.getAuthKey();
    final dio = Dio();
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Authorization"] = "Bearer " + (token ?? ""); // config your dio headers globally
    dio.options.followRedirects = false;
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 3000);
    log(token ?? "", name: "TOKEN");
    return dio.options.headers;
  }

  getHeaderJustContent() {
    var header = Map<String, String>();
    header['Content-Type'] = "application/json";
    return header;
  }
}
