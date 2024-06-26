import 'package:clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}