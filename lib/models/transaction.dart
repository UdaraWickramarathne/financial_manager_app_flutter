import 'package:flutter/material.dart';

class Transaction {
  final Color? boxColor;
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String category;
  final String price;
  final String date;
  final bool isIncome;

  Transaction({
    this.boxColor,
    this.icon,
    this.iconColor,
    required this.title,
    required this.category,
    required this.price,
    required this.date,
    required this.isIncome,
  });
}

List<Transaction> transactions = [
  Transaction(
    title: 'COD BO 6',
    category: 'entertainment',
    price: '20000',
    date: '04 June',
    isIncome: false,
    boxColor: Colors.green.shade200,
    icon: Icons.theaters,
    iconColor: Colors.green.shade900,
  ),
  Transaction(
    title: 'Ice Cream',
    category: 'food',
    price: '100',
    date: '04 June',
    isIncome: false,
    boxColor: Colors.purple.shade200,
    icon: Icons.fastfood,
    iconColor: Colors.purple.shade900,
  ),
  Transaction(
    title: 'Grocery Shopping',
    category: 'food',
    price: '1500',
    date: '01 October',
    isIncome: false,
    boxColor: Colors.green.shade200,
    icon: Icons.fastfood,
    iconColor: Colors.green.shade900,
  ),
  Transaction(
    title: 'Gym Membership',
    category: 'Health',
    price: '3000',
    date: '05 October',
    isIncome: false,
    boxColor: Colors.blue.shade200,
    icon: Icons.health_and_safety,
    iconColor: Colors.blue.shade900,
  ),
  Transaction(
    title: 'Bus Fare',
    category: 'Transport',
    price: '250',
    date: '06 October',
    isIncome: false,
    boxColor: Colors.orange.shade200,
    icon: Icons.directions_bus,
    iconColor: Colors.orange.shade900,
  ),
  Transaction(
    title: 'Concert Tickets',
    category: 'Entertainment',
    price: '4000',
    date: '10 October',
    isIncome: false,
    boxColor: Colors.purple.shade200,
    icon: Icons.theaters,
    iconColor: Colors.purple.shade900,
  ),
  Transaction(
    title: 'Children’s Toys',
    category: 'Kids',
    price: '800',
    date: '12 October',
    isIncome: false,
    boxColor: Colors.red.shade200,
    icon: Icons.child_care,
    iconColor: Colors.red.shade900,
  ),
  Transaction(
    title: 'Shopping Spree',
    category: 'Shopping',
    price: '2500',
    date: '15 October',
    isIncome: false,
    boxColor: Colors.pink.shade200,
    icon: Icons.shopping_cart,
    iconColor: Colors.pink.shade900,
  ),
  Transaction(
    title: 'Salary Received',
    category: 'Income',
    price: '50000',
    date: '20 October',
    isIncome: true,
    boxColor: Colors.lightGreen.shade200,
    icon: Icons.monetization_on,
    iconColor: Colors.lightGreen.shade900,
  ),
  Transaction(
    title: 'Dinner Out',
    category: 'Food',
    price: '1200',
    date: '22 October',
    isIncome: false,
    boxColor: Colors.cyan.shade200,
    icon: Icons.fastfood,
    iconColor: Colors.cyan.shade900,
  ),
  Transaction(
    title: 'Car Insurance',
    category: 'Transport',
    price: '6000',
    date: '25 October',
    isIncome: false,
    boxColor: Colors.teal.shade200,
    icon: Icons.directions_car,
    iconColor: Colors.teal.shade900,
  ),
  Transaction(
    title: 'Book Sale',
    category: 'Other',
    price: '2000',
    date: '30 October',
    isIncome: true,
    boxColor: Colors.brown.shade200,
    icon: Icons.category,
    iconColor: Colors.brown.shade900,
  ),
];
