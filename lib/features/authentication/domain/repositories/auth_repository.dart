import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/user/user_model.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
