import 'dart:io';

import 'package:codebase/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late final Dio dio;
  late final CacheOptions cacheOptions;

  ApiClient._(this.dio, this.cacheOptions); // Private named constructor

  static Future<ApiClient> create() async {
    final Directory dir = await getApplicationDocumentsDirectory(); //Get app directory

    final CacheOptions cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path), //Store cache in Hive
      policy: CachePolicy.request, // Always use cache first if available
      hitCacheOnErrorExcept: [401, 403], // Use cache even if there's an error except Unauthorized errors
      maxStale: const Duration(days: 7), // Cache duration
      priority: CachePriority.high, // High priority for caching
    );

    final Dio dio = Dio(BaseOptions(
      baseUrl: dotenv.get('BASE_URL'),
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(PrettyDioLogger());

    return ApiClient._(dio, cacheOptions); //Return initialized instance
  }

  ///  GET request with centralized error handling
  Future<ResponseData> get(String endpoint, {Map<String, dynamic>? params, bool forceRefresh = false}) async {
    try {
      Options requestOptions = Options(extra: forceRefresh ? {'dio_cache_force_refresh': true} : {});
      Response response = await dio.get(endpoint, queryParameters: params, options: requestOptions);
      return ApiService.response(response);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return ResponseData(error: ApiService.handleError(error), statusCode: 500);
    }
  }

  /// POST request with centralized error handling
  Future<ResponseData> post(String endpoint, {dynamic data}) async {
    try {
      Response response = await dio.post(endpoint, data: data);
      return ApiService.response(response);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return ResponseData(error: ApiService.handleError(error), statusCode: 500);
    }
  }
}
