import 'dart:async';

import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = '/start';

  const StartScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const StartScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/');
    });
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
          'assets/images/logo.jpg',
          height: 175,
          width: 175,
        )),
        Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Продуктовый магазин',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white),
            ))
      ],
    ));
  }
}
