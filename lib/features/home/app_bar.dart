import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          Image.asset(
            height: 70,
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
          Spacer(),
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Image.asset(
                height: 40,
                'assets/images/sandwich.png',
                width: 40, // Adjust the height as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
