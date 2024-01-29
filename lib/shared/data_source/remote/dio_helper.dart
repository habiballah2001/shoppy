import 'package:dio/dio.dart';

import '../local/cache_helper.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String contentType = 'application/json',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': contentType,
      'Authorization': CacheHelper.getData(key: "token") ?? ''
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String contentType = 'application/json',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': contentType,
      'Authorization': CacheHelper.getData(key: "token") ?? ''
    };

    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String contentType = 'application/json',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': contentType,
      'Authorization': CacheHelper.getData(key: "token") ?? ''
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    String lang = 'en',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'content-Type': 'application/json',
      'Authorization': CacheHelper.getData(key: "token") ?? ''
    };
    return await dio!.delete(url);
  }
}
