import 'package:demo_clean_architech_riverpod/features/dashboard/domain/providers/dashboard_providers.dart';
import 'package:demo_clean_architech_riverpod/features/dashboard/presentation/providers/state/dashboard_notifier.dart';
import 'package:demo_clean_architech_riverpod/features/dashboard/presentation/providers/state/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);

  return DashboardNotifier(repository)..fetchProducts();
});
