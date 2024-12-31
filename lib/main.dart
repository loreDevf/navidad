import 'package:flutter/material.dart';
import 'package:navidad/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'navidad',
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
