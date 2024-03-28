import 'dart:convert';

import 'package:demo_clean_architech_riverpod/shared/data/local/storage_service.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/user/user_model.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';
import 'package:demo_clean_architech_riverpod/shared/globals.dart';

abstract class UserDataSource {
  String get storageKey;

  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}

class UserLocalDatasource extends UserDataSource {
  final StorageService storageService;
  UserLocalDatasource(this.storageService);

  @override
  Future<bool> deleteUser() async {
    return await storageService.remove(storageKey);
  }

  @override
  Future<Either<AppException, User>> fetchUser() async {
    final data = await storageService.get(storageKey);

    if (data == null) {
      return Left(AppException(
          message: 'User not found',
          statusCode: 404,
          identifier: 'UserLocalDatasource'));
    }

    final userJson = jsonDecode(data.toString());

    return Right(User.fromJson(userJson));
  }

  @override
  Future<bool> hasUser() async {
    return await storageService.has(storageKey);
  }

  @override
  Future<bool> saveUser({required User user}) async {
    return await storageService.set(storageKey, jsonEncode(user));
  }

  @override
  String get storageKey => USER_LOCAL_STORAGE_KEY;
}
