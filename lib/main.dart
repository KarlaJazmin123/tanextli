import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'widgets/responsive_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanextli',
      debugShowCheckedModeBanner: false,
      home: const ResponsiveWrapper(child: LoginScreen()),
    );
  }
}