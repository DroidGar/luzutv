import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/features/auth/presentation/pages/login_page.dart';
import 'package:luzu/features/auth/presentation/pages/register_page.dart';
import 'package:luzu/features/config_wrap.dart';
import 'package:luzu/features/home/presentation/pages/home_page.dart';
import 'package:luzu/features/survey/domain/entities/survey.dart';
import 'package:luzu/features/survey/presentation/pages/survey_stepper_page.dart';
import 'package:luzu/features/user/presentation/pages/complete_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouterService {
  final GoRouter router = GoRouter(
    redirect: (context, state) async {
      if (state.uri.toString() == RegisterPage.routeName ||
          state.uri.toString() == LoginPage.routeName) {
        return null;
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final isLogin = token != null && token.isNotEmpty;

      print('isLogin: $isLogin');
      print(state.uri);

      if (!isLogin) {
        return LoginPage.routeName;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: LoginPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: RegisterPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: HomePage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Material(
            child: ConfigWrap(child: HomePage()),
          );
        },
      ),
      GoRoute(
        path: SurveyStepperPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return SurveyStepperPage(
              survey: GoRouterState.of(context).extra! as Survey);
        },
      ),
      GoRoute(
          path: CompleteProfilePage.routeName,
          builder: (context, state) {
            return const CompleteProfilePage();
          }),
    ],
  );
}
