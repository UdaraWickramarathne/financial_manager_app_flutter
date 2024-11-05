import 'package:financial_app/components/update_budget_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class BudgetCard extends StatefulWidget {
  final String id;
  final String title;
  double budgetAmount;
  double spendAmount;
  IconData? icon;
  BudgetCard({
    super.key,
    required this.id,
    required this.title,
    required this.budgetAmount,
    required this.spendAmount,
    required this.icon,
  });

  @override
  State<BudgetCard> createState() => _BudgetCardState();
}

class _BudgetCardState extends State<BudgetCard>
    with SingleTickerProviderStateMixin {
  double _borderRadius = 15.0; // Default border radius
  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
    _slidableController.animation.addListener(() {
      if (_slidableController.animation.value > 0) {
        setState(() {
          _borderRadius = 0.0;
        });
      } else {
        setState(() {
          _borderRadius = 15.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        controller: _slidableController,
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
            showDialog(
              context: context,
              builder: (context) => BudgetUpdatePopup(
                id: widget.id,
                budgetAmount: widget.budgetAmount,
                title: widget.title,
                selectedPeriod: 'Weekly',
              ),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceDim,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        bottomLeft: const Radius.circular(15),
                        topRight: Radius.circular(_borderRadius),
                        bottomRight: Radius.circular(_borderRadius),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 219, 228, 255),
                                ),
                                child: Icon(
                                  widget.icon,
                                  size: 30,
                                  color: const Color(0xFF456EFE),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Rs ${widget.spendAmount.round()}/${widget.budgetAmount.round()}',
                                          style: const TextStyle(
                                            color: Color(0xFF456EFE),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: LinearPercentIndicator(
                                            padding: EdgeInsets.zero,
                                            percent: 0.4,
                                            progressColor:
                                                const Color(0xFF456EFE),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 219, 228, 255),
                                            barRadius:
                                                const Radius.circular(20),
                                            animation: true,
                                            animationDuration: 1000,
                                          ),
                                        ),
                                        const Text('50%'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
