import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment(0.7, 0),
                end: Alignment.centerRight,
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/onboard/analyze.png',
                height: 300,
              ),
            ),
            const Text(
              'Control Your Spending with Ease  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Categorize expenses and monitor spending patterns across different areas, helping them allocate money wisely and track where they\'re spending the most.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
