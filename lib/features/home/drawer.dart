import 'package:flutter/material.dart';

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
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
