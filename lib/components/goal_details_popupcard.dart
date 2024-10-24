import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalDetailsCard extends StatefulWidget {
  const GoalDetailsCard({super.key});

  @override
  State<GoalDetailsCard> createState() => _GoalDetailsCardState();
}

class _GoalDetailsCardState extends State<GoalDetailsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and the fade animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start with the fully visible widget
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  void _closeCard(BuildContext context) {
    // Trigger the fade-out animation
    _controller.reverse().then((_) {
      // Pop the page after the animation completes
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'details',
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: FadeTransition(
              opacity: _fadeAnimation, // Apply the fade animation
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularPercentIndicator(
                            progressColor: const Color(0xFF456EFE),
                            backgroundColor:
                                const Color.fromARGB(255, 219, 228, 255),
                            radius: 30,
                            percent: 0.25,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: const Text('25%'),
                          ),
                          const Text(
                            'New Car',
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Target Amount:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFbabcbb),
                            ),
                          ),
                          Text('Rs.50000.00'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Amount:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFbabcbb),
                            ),
                          ),
                          Text('Rs.20000.00'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Start Date:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFbabcbb),
                            ),
                          ),
                          Text('2024/01/25'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'End Date:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFbabcbb),
                            ),
                          ),
                          Text('2024/09/25'),
                        ],
                      ),
                      const SizedBox(height: 25),
                      TextButton(
                        onPressed: () {
                          _closeCard(context);
                        },
                        child: const Text(
                          'Close',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
