import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:financial_app/components/transaction_update_popup.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:financial_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import "dart:developer" as developer;

class TransactionTile extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final double amount;
  final String date;
  final bool isIncome;
  final Timestamp createdAt;
  final void Function(BuildContext)? deleteFunction;

  const TransactionTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.createdAt,
    required this.date,
    required this.isIncome,
    required this.id,
    required this.deleteFunction,
  });

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat("dd MMMM").format(date);
    return formattedDate;
  }

  late String title;
  late String category;
  late double amount;
  late String date;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    category = widget.category;
    amount = widget.amount;
    date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    final Color? containerColor;
    final Color? iconColor;
    final IconData? icon;
    switch (category) {
      case 'Salary':
        iconColor = Colors.green[800]!;
        containerColor = Colors.green[100]!;
        icon = Icons.monetization_on;
        break;
      case 'Business':
        iconColor = Colors.blue[800]!;
        containerColor = Colors.blue[100]!;
        icon = Icons.business_center;
        break;
      case 'Investment':
        iconColor = Colors.orange[800]!;
        containerColor = Colors.orange[100]!;
        icon = Icons.trending_up;
        break;
      case 'Freelance':
        iconColor = Colors.purple[800]!;
        containerColor = Colors.purple[100]!;
        icon = Icons.work;
        break;
      case 'Gift':
        iconColor = Colors.pink[800]!;
        containerColor = Colors.pink[100]!;
        icon = Icons.card_giftcard;
        break;
      case 'Food':
        iconColor = Colors.amber[800]!;
        containerColor = Colors.amber[100]!;
        icon = Icons.fastfood;

        break;
      case 'Sport':
        iconColor = Colors.yellow[800]!;
        containerColor = Colors.yellow[100]!;
        icon = Icons.sports_baseball;
        break;
      case 'Health':
        iconColor = Colors.teal[800]!;
        containerColor = Colors.teal[100]!;
        icon = Icons.local_hospital;
        break;
      case 'Transport':
        iconColor = Colors.deepPurple[800]!;
        containerColor = Colors.deepPurple[100]!;
        icon = Icons.directions_car;
        break;
      case 'Shopping':
        iconColor = Colors.cyan[800]!;
        containerColor = Colors.cyan[100]!;
        icon = Icons.shopping_cart;
        break;
      case 'Kids':
        iconColor = Colors.grey[800]!;
        containerColor = Colors.grey[100]!;
        icon = Icons.child_care;
        break;
      case 'Entertainment':
        iconColor = Colors.green[800]!;
        containerColor = Colors.green[100]!;
        icon = Icons.movie;
        break;
      case 'Education':
        iconColor = Colors.deepOrange[800]!;
        containerColor = Colors.deepOrange[100]!;
        icon = Icons.school;
        break;
      case 'Other':
        iconColor = Colors.brown[800]!;
        containerColor = Colors.brown[100]!;
        icon = Icons.category;
        break;
      default:
        iconColor = Colors.black;
        containerColor = Colors.grey[100]!;
        icon = Icons.category;
    }
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.deleteFunction,
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
        onTap: () async {
          final updatedTransaction = await showDialog<Transaction>(
            context: context,
            builder: (context) => TransactionUpdatePopUp(
              title: title,
              id: widget.id,
              date: date,
              selectedCategory: category,
              amount: amount,
              icon: icon,
              createdAt: widget.createdAt,
              containerColor: containerColor,
              iconColor: iconColor,
              isIncome: widget.isIncome,
            ),
          );
          if (updatedTransaction != null) {
            developer.log(updatedTransaction.toString());
            setState(() {
              title = updatedTransaction.title;
              amount = updatedTransaction.amount;
              date = updatedTransaction.date;
              category = updatedTransaction.category;
            });
          }
        },
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: containerColor,
                      ),
                      child: Icon(
                        icon,
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
                          AppLocalizations.of(context).translate(category),
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
                      widget.isIncome ? '+\$$amount' : '-\$$amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                    Text(
                      formatDate(date),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
