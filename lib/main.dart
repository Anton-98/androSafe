import 'package:flutter/material.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:safe_droid/components/notification.dart';
import 'package:safe_droid/screens/home.dart';
import 'package:safe_droid/screens/sidebar.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
