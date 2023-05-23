import 'package:flutter/material.dart';
import 'package:safe_droid/screens/accueil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Accueil(),
      ),
    );
  }
}
