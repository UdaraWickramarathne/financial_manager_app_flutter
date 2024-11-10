import 'package:financial_app/models/transaction.dart';

abstract class BaseTransactionRepository {
  Future<void> addTransaction({required Transaction transaction});

  Future<List<Transaction>> getTransactions({required String userID});

  Future<void> deleteTransaction({required String transactionID});

  Future<void> updateTransaction(
      {required String transactionID, required Transaction transaction});

  Future<Map<String, double>> getTotalIncomeExpense({required String userID});

  Future<Map<String, dynamic>> getWeeklyTotals(
      {required String userID, required DateTime startDate});
}
