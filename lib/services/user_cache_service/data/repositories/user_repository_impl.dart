import 'package:demo_clean_architech_riverpod/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:demo_clean_architech_riverpod/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/user/user_model.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;
  UserRepositoryImpl(this.dataSource);

  @override
  Future<bool> deleteUser() {
    return dataSource.deleteUser();
  }

  @override
  Future<Either<AppException, User>> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<bool> hasUser() {
    return dataSource.hasUser();
  }

  @override
  Future<bool> saveUser({required User user}) {
    return dataSource.saveUser(user: user);
  }
}
