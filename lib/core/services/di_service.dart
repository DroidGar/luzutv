import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:luzu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:luzu/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:luzu/features/auth/data/repositories/auth_repository.dart';
import 'package:luzu/features/auth/domain/repsitories/auth_repository_base.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_firebase.dart';
import 'package:luzu/features/auth/domain/usecases/login_on_server.dart';
import 'package:luzu/features/auth/domain/usecases/login_with_google.dart';
import 'package:luzu/features/auth/domain/usecases/logout.dart';
import 'package:luzu/features/auth/domain/usecases/register_on_firebase.dart';
import 'package:luzu/features/auth/presentation/manager/auth_interceptor.dart';
import 'package:luzu/features/auth/presentation/manager/login_cubit.dart';
import 'package:luzu/features/auth/presentation/manager/register_cubit.dart';
import 'package:luzu/features/survey/data/datasource/survey_remote_data_source.dart';
import 'package:luzu/features/survey/data/repositories/survey_repository.dart';
import 'package:luzu/features/survey/domain/repositories/survey_repository_base.dart';
import 'package:luzu/features/survey/domain/use_cases/load_survey.dart';
import 'package:luzu/features/survey/domain/use_cases/save_survey.dart';
import 'package:luzu/features/survey/presentation/manager/survey_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);

  getIt.registerLazySingleton<AuthLocalDataSourceBase>(() => AuthLocalDataSource(getIt()));

  final client = InterceptedClient.build(
    interceptors: [AuthInterceptor(getIt())],
  );

  getIt.registerLazySingleton<Client>(() => client);

  final firebase = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => firebase);

  getIt.registerLazySingleton<AuthRemoteDataSourceBase>(() => AuthRemoteDataSource(getIt(), getIt()));
  getIt.registerLazySingleton<SurveyRemoteDataSourceBase>(() => SurveyRemoteDataSource(getIt()));

  getIt.registerLazySingleton<AuthRepositoryBase>(() => AuthRepository(getIt(), getIt()));
  getIt.registerLazySingleton<SurveyRepositoryBase>(() => SurveyRepository(getIt()));

  getIt.registerLazySingleton<LoginOnServer>(() => LoginOnServer(getIt()));
  getIt.registerLazySingleton<RegisterOnFirebase>(() => RegisterOnFirebase(getIt()));
  getIt.registerLazySingleton<LoginOnFirebase>(() => LoginOnFirebase(getIt()));
  getIt.registerLazySingleton<LoginWithGoogle>(() => LoginWithGoogle(getIt()));
  getIt.registerLazySingleton<LoadSurvey>(() => LoadSurvey(getIt()));
  getIt.registerLazySingleton<SaveSurvey>(() => SaveSurvey(getIt()));
  getIt.registerLazySingleton<Logout>(() => Logout(getIt()));

  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit(getIt(), getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<SurveyCubit>(() => SurveyCubit(getIt(), getIt()));
}
