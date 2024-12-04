import 'package:bloc/bloc.dart';
import 'package:luzu/core/failure/failure.dart';
import 'package:luzu/features/auth/data/models/register_data_model.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_server.dart';
import 'package:luzu/features/auth/domain/usecases/register_on_firebase.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final LoginOnServer loginOnServer;
  final RegisterOnFirebase registerOnFirebase;

  RegisterCubit(this.loginOnServer, this.registerOnFirebase) : super(RegisterInitial());

  actionRegister(String email, String password) async {
    emit(OnLoading());
    final data = RegisterDataModel(email: email, password: password);
    final registerResult = await registerOnFirebase(data);
    registerResult.fold(
      (l) => emit(OnRegisterFailure(l)),
      (r) => emit(OnRegisterSuccess(r)),
    );
  }

  actionLogin(String uid) async {
    emit(OnLoading());
    final result = await loginOnServer(uid);
    result.fold(
      (l) => emit(OnLoginFailure(l)),
      (r) => emit(OnLoginSuccess()),
    );
  }
}
