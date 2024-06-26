import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/auth/domain/entites/user.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Register implements UseCases<User, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    try {
     final user = await repository.register(params.username, params.email, params.password);
     return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

class RegisterParams {
  final String username;
  final String email;
  final String password;

  RegisterParams({required this.username, required this.email, required this.password});
}