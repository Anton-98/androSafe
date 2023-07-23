import 'package:flutter/material.dart';
import 'package:safe_droid/components/constantes.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: cBlanc,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.width * 0.2,
            padding: EdgeInsets.only(
              left: size.width * 0.1 - 20,
              top: size.width * 0.1 - 20,
            ),
            decoration: const BoxDecoration(
                // color: cBleuFonce,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 36,
                  color: cBleuFonce,
                ),
                SizedBox(
                  width: size.width * 0.2,
                ),
                Text(
                  "Parametres",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"))
        ],
      ),
    );
  }
}
