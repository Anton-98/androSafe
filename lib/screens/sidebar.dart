import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_droid/components/constantes.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: Container(
        width: size.width,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: cBlanc,
        ),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: 12,
              left: size.width * 0.1 - 30,
              right: size.width * 0.1 - 30,
            ),
            decoration: const BoxDecoration(
              color: cBleuClair,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Infos",
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      "Acceul",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      "Acceul",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
