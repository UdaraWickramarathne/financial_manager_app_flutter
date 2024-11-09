import 'package:financial_app/components/visa-master-cards/master_card_2.dart';
import 'package:financial_app/components/visa-master-cards/master_card_3.dart';
import 'package:financial_app/components/visa-master-cards/visa_card_1.dart';
import 'package:financial_app/components/visa-master-cards/visa_card_2.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:financial_app/screens/cards/add_card_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title:  Center(
          child: Text(
            AppLocalizations.of(context).translate('my_cards'),
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 210,
              child: PageView(
                controller: _controller,
                children: const [
                  VisaCard1(),
                  VisaCard2(),
                  MasterCard3(),
                  MasterCard2(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: SwapEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Theme.of(context).colorScheme.surfaceDim,
              dotHeight: 10,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('add_new_card'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                           Text(
                            AppLocalizations.of(context).translate('save_time_by_adding_cards'),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.surfaceDim,
                            ),
                            padding: const WidgetStatePropertyAll(
                                EdgeInsets.all(13))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddCardPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
