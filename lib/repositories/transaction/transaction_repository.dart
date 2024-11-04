import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/transaction/base_transaction_repository.dart';
import 'dart:developer' as developer;

class TransactionRepository extends BaseTransactionRepository {
  final CollectionReference _transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');

  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    try {
      final doc = _transactionsCollection.doc();
      transaction.id = doc.id;
      await doc.set(transaction.toJson());
      developer.log('transaction add success');
    } catch (e) {
      developer.log('transaction adding error ${e.toString()}');
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
