import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Color? boxColor;
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String description;
  final String price;
  final String date;
  final bool isIncome;

  const TransactionTile({
    super.key,
    required this.boxColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.price,
    required this.date,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // For icon and  description
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: boxColor,
                ),
                child: Icon(
                  Icons.electric_bolt_outlined,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
          //For balance and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isIncome ? '+\$$price' : '-\$$price',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
