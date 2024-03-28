import 'package:demo_clean_architech_riverpod/shared/data/remote/network_service.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/paginated_response.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';
import 'package:demo_clean_architech_riverpod/shared/globals.dart';

abstract class DashboardDataSource {
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts(
      {required int skip});
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts(
      {required int skip, required String query});
}

class DashboardRemoteDatasource extends DashboardDataSource {
  final NetWorkService netWorkService;

  DashboardRemoteDatasource(this.netWorkService);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts(
      {required int skip}) async {
    final response = await netWorkService.get('/products',
        queryParameters: {'skip': skip, 'limit': PRODUCTS_PER_PAGE});

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(AppException(
            message: 'The data is not in the valid format',
            statusCode: 0,
            identifier: 'fetchPaginatedData'));
      }

      final paginatedResponse =
          PaginatedResponse.fromJson(jsonData, jsonData['products'] ?? []);

      return Right(paginatedResponse);
    });
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts(
      {required int skip, required String query}) async {
    final response = await netWorkService.get('/products/search?=$query',
        queryParameters: {'skip': skip, 'limit': PRODUCTS_PER_PAGE});

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;

      if (jsonData == null) {
        return Left(AppException(
            message: 'The data is not in the valid format',
            statusCode: 0,
            identifier: 'search PaginatedData'));
      }

      final paginatedResponse =
          PaginatedResponse.fromJson(jsonData, jsonData['products'] ?? []);

      return Right(paginatedResponse);
    });
  }
}
