import 'package:expandable_richtext/expandable_rich_text.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Pouquoi",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: cBleuFonce,
                  fontSize: 20,
                ),
              ),
              ExpandableRichText(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
