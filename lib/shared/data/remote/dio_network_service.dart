import 'package:demo_clean_architech_riverpod/configs/app_configs.dart';
import 'package:demo_clean_architech_riverpod/shared/data/remote/remote.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/response.dart'
    as response;
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';
import 'package:demo_clean_architech_riverpod/shared/globals.dart';
import 'package:demo_clean_architech_riverpod/shared/mixins/exception_handler_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioNetWorkService extends NetWorkService with ExceptionHandlerMixin {
  final Dio dio;

  DioNetWorkService(this.dio) {
    if (!kTestMode) {
      dio.options = dioBaseOptions;
      if (kDebugMode) {
        dio.interceptors
            .add(LogInterceptor(requestBody: true, responseBody: true));
      }
    }
  }

  @override
  String get baseUrl => AppConfigs.baseUrl;

  BaseOptions get dioBaseOptions =>
      BaseOptions(baseUrl: baseUrl, headers: headers);

  @override
  Future<Either<AppException, response.Response>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    final res = handlerException(
        () => dio.get(endpoint, queryParameters: queryParameters),
        endpoint: endpoint);

    return res;
  }

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  @override
  Future<Either<AppException, response.Response>> post(String endpoint,
      {Map<String, dynamic>? data}) {
    final res = handlerException(() => dio.post(endpoint, data: data));

    return res;
  }

  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};

    if (!kTestMode) {
      dio.options.headers = header;
    }

    return header;
  }
}
