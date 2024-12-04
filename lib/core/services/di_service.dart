import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:luzu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:luzu/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:luzu/features/auth/data/repositories/auth_repository.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_firebase.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_server.dart';
import 'package:luzu/features/auth/domain/usecases/register_on_firebase.dart';
import 'package:luzu/features/auth/presentation/manager/login_cubit.dart';
import 'package:luzu/features/auth/presentation/manager/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);

  final http =  Client();
  getIt.registerLazySingleton(() => http);

  final firebase = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => firebase);

  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt(), getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(getIt()));

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(), getIt()));

  getIt.registerLazySingleton<LoginOnServer>(() => LoginOnServer(getIt()));
  getIt.registerLazySingleton<RegisterOnFirebase>(() => RegisterOnFirebase(getIt()));
  getIt.registerLazySingleton<LoginOnFirebase>(() => LoginOnFirebase(getIt()));

  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit(getIt(), getIt()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt(), getIt()));
}
