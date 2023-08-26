import 'package:flutter/material.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Aide extends StatefulWidget {
  const Aide({super.key});

  @override
  State<Aide> createState() => _AideState();
}

class _AideState extends State<Aide> {
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            children: [
              Container(
                color: Colors.amber,
                child: const Center(
                  child: Text("Page 1"),
                ),
              ),
              Container(
                color: Colors.green,
                child: const Center(
                  child: Text("Page 2"),
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(
                  child: Text("Page 3"),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => controller.jumpToPage(2),
                  child: const Text("Skip")),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const JumpingDotEffect(
                      jumpScale: .7,
                      verticalOffset: 15,
                      dotHeight: 16,
                      dotWidth: 16,
                      activeDotColor: cBleuFonce),
                  onDotClicked: (index) => controller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                ),
              ),
              TextButton(
                  onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: const Text("Next"))
            ],
          ),
        ),
      );
}
