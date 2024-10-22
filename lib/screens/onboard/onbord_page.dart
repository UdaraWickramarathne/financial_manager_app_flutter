import 'dart:ui';

import 'package:financial_app/screens/home/home_page.dart';
import 'package:flutter/material.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildPageView() {
    return [
      _buildOnboardingPage(
        title: 'Financial Manager',
        description: 'Manage your finances with ease and control your spending.',
        imageAsset: 'assets/onboard/vecteezy_3d-illustration-learn-math-at-home_20946681.png',
      ),
      _buildOnboardingPage(
        title: 'Track Expenses',
        description: 'Track your daily expenses and stay within your budget.',
        imageAsset: 'assets/onboard/vecteezy_3d-male-character-holding-and-presenting-to-a-laptop-with_24658935.png',
      ),
      _buildOnboardingPage(
        title: 'Analyze Reports',
        description: 'Analyze financial reports and make better decisions.',
        imageAsset: 'assets/onboard/vecteezy_boy-standing-holding-laptop-with-left-hand-giving-thumbs-up_11006184.png',
      ),
      _buildOnboardingPage(
        title: 'Get Started',
        description: 'Start your journey towards better financial management!',
        imageAsset: 'assets/onboard/vecteezy_unique-3d-calendar-alarm-clock-planning-concept-icon_34792246.png',
      ),
    ];
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required String imageAsset,
  }) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF456EFE),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.7, -0.6),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9).withOpacity(0.5),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-0.8, -0.6),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9).withOpacity(0.5),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.02, 0.8),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9).withOpacity(0.5),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.2, 1.2),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9).withOpacity(0.5),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 50.0,
            sigmaY: 50.0,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
        // Main content
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageAsset, height: 300),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _buildPageView(),
          ),
          if (_currentPage < 3)
            Positioned(
              bottom: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (_currentPage < 3)
            Positioned(
              bottom: 37,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  if (_currentPage < 3) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 24,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 10,
                  width: _currentPage == index ? 20 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.white70,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ),
          if (_currentPage == 3)
            Positioned(
              bottom: 37,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
