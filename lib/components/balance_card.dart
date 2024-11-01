import 'package:financial_app/components/glass_effect_icon.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanaceCard extends StatefulWidget {
  const BalanaceCard({super.key});

  @override
  State<BalanaceCard> createState() => _BalanaceCardState();
}

class _BalanaceCardState extends State<BalanaceCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Stack(
      children: [
        Image.asset(
          isDarkMode
              ? 'assets/images/visacard3.png'
              : 'assets/images/visacard1.png',
          height: 210,
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('total_balance'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Color.fromARGB(206, 255, 255, 255),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                '\$3,257.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const GlassEffectIcon(icon: Icons.arrow_downward),
                      const SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context).translate('income'),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const GlassEffectIcon(icon: Icons.arrow_upward),
                      const SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context).translate('expenses'),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Row(
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
      ],
    );
  }
}
