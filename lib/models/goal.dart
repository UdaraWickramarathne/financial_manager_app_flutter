import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  String id;
  final String userID;
  String title;
  double amount;
  String date;
  final Timestamp createdAt;

  Goal({
    this.id = '',
    required this.userID,
    required this.title,
    required this.amount,
    required this.date,
    required this.createdAt,
  });

  toJson() => {
        'id': id,
        'userID': userID,
        'title': title,
        'amount': amount,
        'date': date,
        'createdAt': createdAt,
      };

  factory Goal.fromJson(dynamic json) {
    return Goal(
      id: json['id'],
      userID: json['userID'],
      title: json['title'],
      amount: json['amount'],
      date: json['date'],
      createdAt: json['createdAt'],
    );
  }
}
