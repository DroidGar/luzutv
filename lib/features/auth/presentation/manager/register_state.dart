part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class OnLoading extends RegisterState {}

final class OnRegisterSuccess extends RegisterState {
  final String uid;

  OnRegisterSuccess(this.uid);
}

final class OnRegisterFailure extends RegisterState {
  final Failure failure;

  OnRegisterFailure(this.failure);
}

final class OnLoginSuccess extends RegisterState {}

final class OnLoginFailure extends RegisterState {
  final Failure failure;

  OnLoginFailure(this.failure);
}