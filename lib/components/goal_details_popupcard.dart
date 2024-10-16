import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalDetailsCard extends StatelessWidget {
  const GoalDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'details',
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
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
                            fontFamily: 'SofiaPro',
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
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
