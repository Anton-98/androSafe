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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
              child: const Text("Parametres Généraux"),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 7),
              decoration: BoxDecoration(
                color: cBlanc.withOpacity(1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Analyse Statique Auto",
                      style: TextStyle(color: cBleuClair),
                    ),
                    textColor: cBlanc,
                    trailing: Switch(
                      activeColor: cBleuFonce,
                      activeTrackColor: cBleuFonce,
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
                    height: 1,
                    thickness: 0.7,
                    endIndent: 12,
                    color: cBleuFonce,
                    indent: 12,
                  ),
                  ListTile(
                    title: const Text(
                      "Analyse Dynamique Auto",
                      style: TextStyle(color: cBleuClair),
                    ),
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
              child: const Text(
                "Conditions et Politiques",
                style: TextStyle(color: cBleuFonce),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 7),
              decoration: BoxDecoration(
                color: cBlanc.withOpacity(1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Politique de Confidentialité",
                      style: TextStyle(color: cBleuClair),
                    ),
                    leading: const Icon(
                      Icons.security_outlined,
                      color: cBleuFonce,
                    ),
                    textColor: cBlanc,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).pushNamed("/politique");
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.7,
                    endIndent: 12,
                    color: cBleuFonce,
                    indent: 12,
                  ),
                  ListTile(
                    title: const Text(
                      "Conditions Générales d'Utilisation",
                      style: TextStyle(color: cBleuClair),
                    ),
                    leading: const Icon(
                      Icons.verified_user_rounded,
                      color: cBleuFonce,
                    ),
                    textColor: cBlanc,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.7,
                    endIndent: 12,
                    color: cBleuFonce,
                    indent: 12,
                  ),
                  ListTile(
                    title: const Text(
                      "FAQ",
                      style: TextStyle(color: cBleuClair),
                    ),
                    leading: const Icon(
                      Icons.question_answer_sharp,
                      color: cBleuFonce,
                    ),
                    textColor: cBlanc,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, top: 30, right: 12),
              child: const Text("A propos"),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 7),
              decoration: BoxDecoration(
                color: cBlanc.withOpacity(1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Aide",
                      style: TextStyle(color: cBleuClair),
                    ),
                    textColor: cBlanc,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).pushNamed("/aide");
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.7,
                    endIndent: 12,
                    color: cBleuFonce,
                    indent: 12,
                  ),
                  ListTile(
                    title: const Text(
                      "Version",
                      style: TextStyle(color: cBleuClair),
                    ),
                    trailing: Text("$_version "),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
