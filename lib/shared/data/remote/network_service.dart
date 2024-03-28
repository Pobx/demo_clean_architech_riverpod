import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/response.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';

abstract class NetWorkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, Response>> post(String endpoint,
      {Map<String, dynamic>? data});
}
