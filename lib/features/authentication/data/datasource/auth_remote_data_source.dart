import 'package:demo_clean_architech_riverpod/shared/data/remote/remote.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/either.dart';
import 'package:demo_clean_architech_riverpod/shared/domain/models/user/user_model.dart';
import 'package:demo_clean_architech_riverpod/shared/exceptions/http_exception.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetWorkService netWorkService;
  LoginUserRemoteDataSource(this.netWorkService);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    try {
      final eitherType =
          await netWorkService.post('/auth/login', data: user.toJson());

      return eitherType.fold((exception) => Left(exception), (response) {
        final user = User.fromJson(response.data);
        netWorkService.updateHeader({'Authorization': user.token});
        return Right(user);
      });
    } catch (e) {
      return Left(AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser'));
    }
  }
}
