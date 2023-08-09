import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_droid/components/background_service.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:safe_droid/components/notification.dart';
import 'package:safe_droid/screens/afterAnalyse.dart';
import 'package:safe_droid/screens/home.dart';
import 'package:safe_droid/screens/sidebar.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) => {
      if (value) {Permission.notification.request()}
    },
  );
  await initializeService();

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
        '': (_) => const Affichage(),
      },
    );
  }
}
