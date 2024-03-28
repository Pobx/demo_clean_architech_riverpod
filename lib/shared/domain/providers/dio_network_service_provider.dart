import 'package:demo_clean_architech_riverpod/shared/data/remote/remote.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<DioNetWorkService>((ref) {
  final Dio dio = Dio();
  return DioNetWorkService(dio);
});
