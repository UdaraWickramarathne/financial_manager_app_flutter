import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/transaction/base_transaction_repository.dart';
import 'dart:developer' as developer;

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
}
