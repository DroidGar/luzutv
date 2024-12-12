import 'package:bloc/bloc.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/domain/entities/user.dart';
import 'package:luzu/features/auth/domain/usecases/me.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Me me;
  HomeCubit(this.me) : super(HomeInitial());

  void loadMe() async {
    emit(HomeLoading());
    final result = await me();
    result.fold(
      (l) => emit(HomeFailure(l)),
      (r) => emit(HomeLoaded(r)),
    );
  }
}
