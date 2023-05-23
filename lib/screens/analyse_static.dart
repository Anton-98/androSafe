import 'package:flutter/material.dart';

class Static extends StatelessWidget {
  const Static({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.5,
          width: size.width,
        ),
        Text("data")
      ],
    );
  }
}
