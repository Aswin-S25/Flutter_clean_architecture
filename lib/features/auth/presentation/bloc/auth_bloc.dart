import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/domain/entites/user.dart';
import 'package:clean_architecture/features/auth/domain/usecases/login.dart';
import 'package:clean_architecture/features/auth/domain/usecases/register.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;

  AuthBloc({required this.login, required this.register})
      : super(AuthInitial()) {
    on<LoginEvent>(loginEvent);
    on<RegisterEvent>(registerEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final Either<Failure, User> failureorUser = await login(
        LoginParams(username: event.username, password: event.password));

    emit(failureorUser.fold(
        (failure) => AuthError(message: _mapFailureToMessage(failure)),
        (user) => AuthLoaded(user: user)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      default:
        return 'unexpected Error';
    }
  }

  FutureOr<void> registerEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, User> failureorUser = await register(RegisterParams(
        username: event.username,
        email: event.email,
        password: event.password));

    emit(failureorUser.fold(
        (failure) => AuthError(message: _mapFailureToMessage(failure)),
        (user) => AuthLoaded(user: user)));
  }
}
