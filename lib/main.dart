import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_droid/components/background_service.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:safe_droid/components/notification.dart';
import 'package:safe_droid/components/splash.dart';
import 'package:safe_droid/screens/notif.dart';
import 'package:safe_droid/screens/param.dart';
import 'package:safe_droid/screens/param/aide.dart';
import 'package:safe_droid/screens/param/politique_conf.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) => {
      if (value)
        {
          Permission.notification.request(),
        }
    },
  );

  await NotificationService.initializeNotification();
  await SharedPreferences.getInstance();
  await initializeService();
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
        textTheme: Theme.of(context).textTheme.apply(bodyColor: cBleuFonce),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        body: Splash(),
      ),
      routes: {
        '/menu': (_) => const Menu(),
        '/aide': (_) => const Aide(),
        '/politique': (_) => const Politique(),
        '/notifications': (_) => const Notifications(),
        //'': (_) => const Affichage(),
      },
    );
  }
}
