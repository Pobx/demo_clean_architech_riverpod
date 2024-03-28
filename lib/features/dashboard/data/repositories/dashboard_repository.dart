import 'package:demo_clean_architech_riverpod/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:demo_clean_architech_riverpod/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/paginated_response.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardDataSource dashboardDataSource;

  DashboardRepositoryImpl(this.dashboardDataSource);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchProducts(
      {required int skip}) {
    return dashboardDataSource.fetchPaginatedProducts(skip: skip);
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchProducts(
      {required int skip, required String query}) {
    return dashboardDataSource.searchPaginatedProducts(
        skip: skip, query: query);
  }
}
