import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/constantes.dart';

class Politique extends StatelessWidget {
  const Politique({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("Politique de confidentialité"),
        titleTextStyle: const TextStyle(
            fontSize: 15,
            color: cBleuFonce,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(left: 12, right: 12, top: 7),
          decoration: BoxDecoration(
            color: cBlanc.withOpacity(1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              Text(
                "Notre application de détection de malware Android est conçue pour protéger les appareils Android des logiciels malveillants. Nous collectons et utilisons des données personnelles pour fournir et améliorer nos services. Cette politique de confidentialité explique ce que nous collectons, comment nous l'utilisons et comment vous pouvez contrôler vos données.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
