import 'dart:ui';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bitcoin-min.jpg'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'The Smart \nApp for \nYour Financial Life',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      height: 1.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 450),
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTapDown: (details) {
                            setState(() {
                              isTapped = true;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              isTapped = false;
                            });
                          },
                          child: Container(
                            width: 250,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                // Apply the blur effect
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 1.0, sigmaY: 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: isTapped
                                              ? [
                                                  const Color.fromARGB(
                                                      174, 255, 255, 255),
                                                  const Color.fromARGB(
                                                      118, 255, 255, 255),
                                                ]
                                              : [
                                                  const Color.fromARGB(
                                                      111, 255, 255, 255),
                                                  const Color.fromARGB(
                                                      55, 255, 255, 255),
                                                ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(-6, -6),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                          ),
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: const Offset(6, 6),
                                            blurRadius: 16,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Create an Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
