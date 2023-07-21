import 'package:flutter/material.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:safe_droid/screens/home.dart';
import 'package:safe_droid/screens/sidebar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: cBleuClair,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: cBleuClair),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        body: Home(),
      ),
      routes: {
        '/menu': (_) => const Menu(),
      },
    );
  }
}
