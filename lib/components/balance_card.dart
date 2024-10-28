import 'package:financial_app/components/glass_effect_icon.dart';
import 'package:flutter/material.dart';

class BalanaceCard extends StatelessWidget {
  const BalanaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 365,
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF456EFE), // Dark blue
                Color.fromARGB(255, 73, 164, 238), // Light blue
                Color.fromARGB(255, 38, 128, 198), // Medium blue
              ],
              begin: AlignmentDirectional(-1, 1),
              end: AlignmentDirectional(1, -1),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color.fromARGB(206, 255, 255, 255),
                        )
                      ],
                    ),
                    Text(
                      '\u00B7\u00B7\u00B7',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '\$3,257.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GlassEffectIcon(icon: Icons.arrow_downward),
                        SizedBox(width: 5),
                        Text(
                          'Income',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GlassEffectIcon(icon: Icons.arrow_upward),
                        SizedBox(width: 5),
                        Text(
                          'Expenses',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$2350.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$950.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
