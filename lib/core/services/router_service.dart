import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/features/auth/presentation/pages/login_page.dart';
import 'package:luzu/features/auth/presentation/pages/register_page.dart';
import 'package:luzu/features/config_wrap.dart';
import 'package:luzu/features/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouterService {
  final GoRouter router = GoRouter(
    redirect: (context, state) async {
      if (state.uri.toString() == RegisterPage.routeName ||
          state.uri.toString() == LoginPage.routeName) {
        return null;
      }

      final prefs = await SharedPreferences.getInstance();
      final token =  prefs.getString('token');
      final isLogin = token != null && token.isNotEmpty;

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
          return const ConfigWrap(child: HomePage());
        },
      ),
    ],
  );
}
