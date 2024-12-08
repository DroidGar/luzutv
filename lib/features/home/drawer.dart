import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/core/services/router_service.dart';
import 'package:luzu/features/auth/domain/usecases/logout.dart';
import 'package:luzu/features/auth/presentation/pages/login_page.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.blue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 150, // Adjust the height as needed
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text('Salir'),
          onTap: () async {
            final logout = getIt.get<Logout>();
            await logout();
            context.go(LoginPage.routeName);
          },
        ),
      ],
    ),
  );
}
