
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/transaction/base_transaction_repository.dart';
import 'dart:developer' as developer;

import 'package:intl/intl.dart';

class TransactionRepository extends BaseTransactionRepository {
  final CollectionReference _transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');
  final CollectionReference _budgetsCollection =
      FirebaseFirestore.instance.collection('budgets');

  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    try {
      // Start a Firestore batch
      final batch = FirebaseFirestore.instance.batch();

      // Create a new document reference for the transaction
      final transactionDoc = _transactionsCollection.doc();
      transaction.id = transactionDoc.id;

      // Add the transaction to the batch
      batch.set(transactionDoc, transaction.toJson());

      // Check if a budget exists for the user and category
      final budgetQuery = await _budgetsCollection
          .where('userID', isEqualTo: transaction.userID)
          .where('category', isEqualTo: transaction.category)
          .limit(1)
          .get();

      if (budgetQuery.docs.isNotEmpty) {
        final budgetDoc = budgetQuery.docs.first;
        final budgetRef = budgetDoc.reference;

        // Calculate the new currentAmount
        final currentAmount = budgetDoc['currentAmount'] ?? 0.0;
        final newCurrentAmount = currentAmount + transaction.amount;

        // Update the budget's currentAmount in the batch
        batch.update(budgetRef, {'currentAmount': newCurrentAmount});
      }

      // Commit the batch to apply all changes
      await batch.commit();
      developer.log('Transaction added and budget updated successfully.');
    } catch (e) {
      developer
          .log('Error adding transaction and updating budget: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction({required String transactionID}) async {
    try {
      await _transactionsCollection.doc(transactionID).delete();
      developer.log('transaction delete success');
    } catch (e) {
      developer.log('transaction deleting error');
      rethrow;
    }
  }

  @override
  Future<List<Transaction>> getTransactions({required String userID}) async {
    try {
      final querySnapshot = await _transactionsCollection
          .where('userID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();
      developer.log('transaction get success');
      return querySnapshot.docs
          .map((doc) => Transaction.fromJson(doc.data()))
          .toList();
    } catch (e) {
      developer.log('transaction fetching error ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> updateTransaction(
      {required String transactionID, required Transaction transaction}) async {
    try {
      await _transactionsCollection
          .doc(transactionID)
          .set(transaction.toJson(), SetOptions(merge: true));
      developer.log('transaction updated');
    } catch (e) {
      developer.log('transaction fail ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Map<String, double>> getTotalIncomeExpense(
      {required String userID}) async {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    try {
      // Get the start of the current month
      DateTime now = DateTime.now();
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      Timestamp startOfMonthTimestamp = Timestamp.fromDate(startOfMonth);

      // Calculate income for the current month
      QuerySnapshot incomeSnapshot = await _transactionsCollection
          .where('userID', isEqualTo: userID)
          .where('isIncome', isEqualTo: true)
          .where('createdAt', isGreaterThanOrEqualTo: startOfMonthTimestamp)
          .get();

      for (var doc in incomeSnapshot.docs) {
        var transaction = Transaction.fromJson(doc.data());
        totalIncome += transaction.amount;
      }

      // Calculate expense for the current month
      QuerySnapshot expenseSnapshot = await _transactionsCollection
          .where('userID', isEqualTo: userID)
          .where('isIncome', isEqualTo: false)
          .where('createdAt', isGreaterThanOrEqualTo: startOfMonthTimestamp)
          .get();

      for (var doc in expenseSnapshot.docs) {
        var transaction = Transaction.fromJson(doc.data());
        totalExpense += transaction.amount;
      }

      developer.log('Monthly transaction totals updated');
      return {
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
      };
    } catch (e) {
      developer.log('Error updating monthly transaction totals: $e');
      return {
        'totalIncome': 0.0,
        'totalExpense': 0.0,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> getWeeklyTotals(
      {required String userID, required DateTime startDate}) async {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    List<String> dateRange = List.generate(7, (index) {
      return dateFormat.format(startDate.add(Duration(days: index)));
    });

    try {
      // Initialize Firestore query
      QuerySnapshot querySnapshot = await _transactionsCollection
          .where('userID', isEqualTo: userID)
          .where('date', whereIn: dateRange)
          .get();

      // Initialize a map to store daily income and expenses
      Map<String, Map<String, double>> dailyTotals = {
        for (var date in dateRange) date: {'income': 0.0, 'expense': 0.0}
      };

      for (var doc in querySnapshot.docs) {
        Transaction transaction = Transaction.fromJson(doc.data());

        // Ensure the transaction date is within the range
        if (dailyTotals.containsKey(transaction.date)) {
          if (transaction.isIncome) {
            dailyTotals[transaction.date]!['income'] =
                (dailyTotals[transaction.date]!['income'] ?? 0.0) +
                    transaction.amount;
          } else {
            dailyTotals[transaction.date]!['expense'] =
                (dailyTotals[transaction.date]!['expense'] ?? 0.0) +
                    transaction.amount;
          }
        }
      }

      // Convert the daily totals to a list of maps
      List<Map<String, dynamic>> weeklyTotals = dateRange.map((date) {
        return {
          'date': date,
          'income': dailyTotals[date]!['income'],
          'expense': dailyTotals[date]!['expense'],
        };
      }).toList();

      // Calculate the highest value across both income and expense
      double highestValue = 0.0;

      for (var dailyTotal in weeklyTotals) {
        highestValue = [
          highestValue,
          dailyTotal['income'],
          dailyTotal['expense']
        ].reduce((a, b) => a > b ? a : b);
      }

      return {
        'weeklyTotals': weeklyTotals,
        'highestValue': highestValue,
      };
    } catch (e) {
      rethrow;
    }
  }
}
