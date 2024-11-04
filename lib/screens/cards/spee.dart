import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Spee extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  Spee({super.key});

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('TTS Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _speak('Hello, this is a voice message.');
            },
            child: const Text('Speak'),
          ),
        ),
      ),
    );
  }
}
