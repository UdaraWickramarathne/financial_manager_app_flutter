import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userID;
  final String name;
  final String email;
  final Timestamp createdAt;
  final String languagePreference;
  final String currencyPreference;
  final String profileImageURL;
  double totalIncome;
  double totalExpense;

  User({
    required this.userID,
    required this.name,
    required this.email,
    required this.createdAt,
    this.languagePreference = 'en',
    this.currencyPreference = 'LKR',
    this.profileImageURL = '',
    this.totalIncome = 0.0,
    this.totalExpense = 0.0,
  });

  toJson() => {
        'userID': userID,
        'name': name,
        'email': email,
        'createdAt': createdAt,
        'languagePreference': languagePreference,
        'currencyPreference': currencyPreference,
        'profileImageURL': profileImageURL,
      };

  factory User.fromJson(dynamic json) {
    return User(
      userID: json['userID'],
      name: json['name'],
      email: json['email'],
      createdAt: json['createdAt'],
      languagePreference: json['languagePreference'],
      currencyPreference: json['currencyPreference'],
      profileImageURL: json['profileImageURL'],
    );
  }
}
