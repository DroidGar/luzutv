part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final User user;

  HomeLoaded(this.user);
}

final class HomeFailure extends HomeState {
  final Failure failure;

  HomeFailure(this.failure);
}