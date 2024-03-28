import 'package:demo_clean_architech_riverpod/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userLoginCheckProvider = FutureProvider((ref) async {
  final repository = ref.watch(userLocalRepositoryProvider);

  return await repository.hasUser();
});
