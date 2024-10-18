import 'package:financial_app/components/goal_details_popupcard.dart';
import 'package:financial_app/components/update_popup_card.dart';
import 'package:financial_app/services/custom_rect_tween.dart';
import 'package:financial_app/services/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalCard extends StatelessWidget {
  final String id;

  const GoalCard({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(
              builder: (context) {
                return const GoalDetailsCard();
              },
            ));
          },
          child: Row(
            children: [
              Expanded(
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05), // Shadow color
                          spreadRadius: 1, // Spread radius of the shadow
                          blurRadius: 10, // Blur effect
                          offset: Offset(0,
                              7), // Horizontal: 0, Vertical: 5 (bottom shadow)
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 219, 228, 255),
                                ),
                                child: const Icon(
                                  Icons.car_rental_sharp,
                                  size: 50,
                                  color: Color(0xFF456EFE),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'New Car',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '25%',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF456EFE),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '13 months left',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFbabcbb),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        LinearPercentIndicator(
                          percent: 0.4,
                          progressColor: const Color(0xFF456EFE),
                          backgroundColor:
                              const Color.fromARGB(255, 219, 228, 255),
                          barRadius: const Radius.circular(20),
                          animation: true,
                          animationDuration: 1000,
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Rs.1200'),
                              Hero(
                                tag: 'update$id',
                                createRectTween: (begin, end) {
                                  return CustomRectTween(
                                      begin: begin, end: end);
                                },
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(HeroDialogRoute(
                                      builder: (context) {
                                        return UpdatePopupCard(
                                          id: id,
                                          targetAmount: 2000,
                                          deadLine: '2024-04-01',
                                          notAchived: 3000,
                                        );
                                      },
                                    ));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        const Color.fromARGB(
                                            255, 219, 228, 255)),
                                    padding:
                                        WidgetStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                    ),
                                    minimumSize:
                                        WidgetStateProperty.all(Size.zero),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Update Progress',
                                    style: TextStyle(
                                      color: Color(0xFF456EFE),
                                    ),
                                  ),
                                ),
                              ),
                              const Text('Rs.200000'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
