import 'package:demo_clean_architech_riverpod/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:demo_clean_architech_riverpod/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:demo_clean_architech_riverpod/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:demo_clean_architech_riverpod/shared/data/remote/remote.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardDatasourceProvider =
    Provider.family<DashboardDataSource, NetWorkService>(
        (_, netWorkService) => DashboardRemoteDatasource(netWorkService));

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final netWorkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(dashboardDatasourceProvider(netWorkService));
  final repository = DashboardRepositoryImpl(datasource);

  return repository;
});
