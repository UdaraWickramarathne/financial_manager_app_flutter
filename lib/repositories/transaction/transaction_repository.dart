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
  Future<void> deleteTransaction({required String userID}) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactions({required String userID}) async {
    try {
      final querySnapshot = await _transactionsCollection
          .where('userID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Transaction.fromJson(doc.data()))
          .toList();
    } catch (e) {
      developer.log('transaction fetching error ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> updateTransaction({required Transaction transaction}) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
