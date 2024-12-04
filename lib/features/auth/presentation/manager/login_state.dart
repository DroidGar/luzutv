part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class OnLoading extends LoginState {}

final class OnLoginSuccess extends LoginState {}

final class OnLoginFailure extends LoginState {
  final Failure failure;
  OnLoginFailure(this.failure);
}