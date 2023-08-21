import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late SharedPreferences _prefs;
  bool analyseStatique = false;
  bool analyseDynamique = false;
  String? _version;
  @override
  void initState() {
    super.initState();
    _initPrefs();
    _getAppVersion();
  }

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      analyseStatique = _prefs.getBool('statiqueAuto') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cBlanc,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cBlanc,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            colorFilter: const ColorFilter.mode(
              cBleuFonce,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Parametres"),
        titleTextStyle: const TextStyle(
            fontSize: 15,
            color: cBleuFonce,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic),
      ),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
              child: const Text("Parametres d'Analyse"),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 7),
              decoration: BoxDecoration(
                color: cBleuFonce.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Analyse Statique Auto"),
                    textColor: cBlanc,
                    trailing: Switch(
                      activeColor: cBleuFonce,
                      activeTrackColor: cBlanc,
                      inactiveTrackColor: cBleuFonce,
                      value: analyseStatique,
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            analyseStatique = value;
                            _prefs.setBool("statiqueAuto", value);
                          });
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 5,
                    color: cBlanc,
                    indent: 30,
                  ),
                  ListTile(
                    title: const Text("Analyse Dynamique Auto"),
                    textColor: cBlanc,
                    trailing: Switch(
                      activeColor: cBleuFonce,
                      value: analyseDynamique,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, top: 30, right: 12),
              child: const Text("Conditions et Politiques"),
            ),
            Text("$_version ")
          ],
        ),
      ),
    );
  }
}
