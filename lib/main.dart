import 'package:app_flutter/screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    initialRoute: '/',
    routes: {
      '/': (context) => const Screen1(),
      '/second': (context) => const Screen2(),
    },
  ));
}
