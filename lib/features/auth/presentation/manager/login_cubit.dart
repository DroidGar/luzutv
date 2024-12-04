import 'package:bloc/bloc.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/data/models/logon_data_model.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_firebase.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_server.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginOnServer loginOnServer;
  final LoginOnFirebase loginOnFirebase;

  LoginCubit(this.loginOnServer, this.loginOnFirebase) : super(LoginInitial());

  void actionLoginOnFirebase(LoginDataModel data) async {
    emit(OnLoading());
    final result = await loginOnFirebase(data);
    result.fold(
      (failure) => emit(OnLoginFailure(failure)),
      (success) => emit(OnLoginSuccess()),
    );
  }

  void actionLogin(String uid) async {
    emit(OnLoading());
    final result = await loginOnServer(uid);
    result.fold(
      (failure) => emit(OnLoginFailure(failure)),
      (success) => emit(OnLoginSuccess()),
    );
  }
}
