// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure;
import 'package:get/get.dart';

BaseOptions options = new BaseOptions(
  headers: {
    "X-Requested-With": "XMLHttpRequest",
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8"
  },
  connectTimeout: Duration(milliseconds: 100000),
  receiveTimeout: Duration(milliseconds: 100000),
);

class NetworkUtil extends GetxController {
  static NetworkUtil instance = Get.find();

  final storage = new secure.FlutterSecureStorage();

  Dio dio = new Dio(options);

  initNetwork(baseUrl) {
    //options.baseUrl = baseUrl;
  }

  setHeader(lang) {
    options.headers = {
      'lang': lang,
    };
    print('lang --------$lang');
  }

  handleError(DioException e) {
    print(e.message);

    //GLOBAL ERROR HANDLER will be here
  }

  Future<dynamic> get(String url, {dynamic params, String? base}) async {
    if (base != null) {
      options.baseUrl = base;
    }

    try {
      String jwt = await storage.read(key: 'jwt') ?? "";
      if (jwt != "") {
        dio.interceptors.add(
          InterceptorsWrapper(onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            options.headers["Authorization"] = "Bearer $jwt";
            return handler.next(options); //continue
          }),
        );
      }
      var response = await dio.get(
        url,
        queryParameters: params ??
            null, /*options: buildCacheOptions(Duration(days: 7), forceRefresh: true),*/
      );
      return response.data;
    } on DioException catch (e) {
      handleError(e);
      print(e.response);
    }
    return null;
  }

  Future<dynamic> post(String url, body,
      {String? base, required String langu}) async {
    // String base = 'https://w2earn.bits.mn';
    if (base != null) {
      options.baseUrl = base;
    }

    try {
      String jwt = await storage.read(key: 'jwt') ?? "";
      // String lang = await storage.read(key: 'lang') ?? "";
      if (jwt != "") {
        dio.interceptors.add(
          InterceptorsWrapper(onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            options.headers["Authorization"] = "Bearer $jwt";
            // langu.isEmpty ? '' : options.headers["lang"] = "$langu";
            options.headers["lang"] = "$langu";
            return handler.next(options); //continue
          }),
        );
      }
      var response = await dio.post(url, data: body);

      return response.data;
    } on DioError catch (e) {
      handleError(e);
      print(e.response);

      if (e.response != null) {
        return e.response!.data;
      } else {
        return null;
      }
    }

    // return null;
  }

  Future<dynamic> get_(String url, {String? base}) async {
    if (base != null) {
      options.baseUrl = base;
    }
    try {
      String jwt = await storage.read(key: 'jwt') ?? "";

      if (jwt != "") {
        dio.interceptors.add(
          InterceptorsWrapper(onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            options.headers["Authorization"] = "Bearer $jwt";

            return handler.next(options); //continue
          }),
        );
      }

      var response = await dio.get(
        url, /*options: buildCacheOptions(Duration(days: 7), forceRefresh: true),*/
      );

      return response.data;
    } on DioException catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<dynamic> post_(String url, body,
      {String? base, bool cache = true}) async {
    if (base != null) {
      options.baseUrl = base;
    }

    try {
      String jwt = await storage.read(key: 'jwt') ?? "";
      if (jwt != "") {
        print("Bearer $jwt");
        dio.interceptors.add(
          InterceptorsWrapper(onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            options.headers["Authorization"] = "Bearer $jwt";
            options.headers["content-type"] = "application/json; charset=UTF-8";

            return handler.next(options); //continue
          }),
        );
      }
      if (cache) {
        var response = await dio.post(
          url,
          data:
              body, /*options: buildCacheOptions(Duration(days: 7), forceRefresh: true)*/
        );

        return response.data;
      } else {
        var response = await dio.post(
          url,
          data:
              body, /*options: buildCacheOptions(Duration(days: 0), forceRefresh: true)*/
        );

        return response.data;
      }
    } on DioException catch (e) {
      handleError(e);
      return e;
    }
  }

  Future<dynamic> getTranslate(String url,
      {dynamic params, String? base}) async {
    if (base != null) {
      options.baseUrl = base;
    }

    try {
      String jwt = await storage.read(key: 'jwt') ?? "";
      if (jwt != "") {
        dio.interceptors.add(
          InterceptorsWrapper(onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            options.headers["Authorization"] = "Bearer $jwt";
            return handler.next(options); //continue
          }),
        );
      }
      var response = await dio.get(
        url,
        queryParameters: params ??
            null, /*options: buildCacheOptions(Duration(days: 7), forceRefresh: true),*/
      );

      return response.data;
    } on DioException catch (e) {
      print('translate dio error ----$e');
    }
  }
}
