import 'package:financial_app/models/transaction.dart';

abstract class BaseTransactionRepository {
  Future<void> addTransaction({required Transaction transaction});

  Future<List<Transaction>> getTransactions({required String userID});

  Future<void> deleteTransaction({required String transactionID});

  Future<void> updateTransaction({required String transactionID});
}
