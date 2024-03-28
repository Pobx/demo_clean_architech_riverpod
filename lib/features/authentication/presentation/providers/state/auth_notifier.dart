import 'package:demo_clean_architech_riverpod/features/authentication/domain/repositories/auth_repository.dart';
import 'package:demo_clean_architech_riverpod/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:demo_clean_architech_riverpod/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/user/user_model.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  AuthNotifier(
      {required this.authenticationRepository, required this.userRepository})
      : super(const AuthState.initial());

  Future<void> logginUser(String username, String password) async {
    state = const AuthState.initial();

    final response = await authenticationRepository.loginUser(
        user: User(username: username, password: password));

    state = await response.fold((failure) => AuthState.failure(failure),
        (user) async {
      final hasSavedUser = await userRepository.saveUser(user: user);
      if (hasSavedUser) {
        return const AuthState.success();
      }

      return AuthState.failure(CacheFailureException());
    });
  }
}
