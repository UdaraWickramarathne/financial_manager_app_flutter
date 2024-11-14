import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_app/models/card.dart';
import 'package:financial_app/repositories/card/base_card_repository.dart';
import 'dart:developer' as dev;

class CardRepository extends BaseCardRepository {
  final CollectionReference _cardCollection =
      FirebaseFirestore.instance.collection('cards');

  @override
  Future<void> addCard({required Card card}) async {
    try {
      final doc = _cardCollection.doc();
      card.id = doc.id;
      await doc.set(card.toJson());
      dev.log('Card added succeess');
    } catch (e) {
      dev.log('Card added error');
      rethrow;
    }
  }

  @override
  Future<void> deleteCard({required String cardID}) async {
    try {
      await _cardCollection.doc(cardID).delete();
      dev.log('Card delete succeess');
    } catch (e) {
      dev.log('Card delete error');
      rethrow;
    }
  }

  @override
  Future<List<Card>> getCrads({required String userID}) async {
    try {
      final querySnapshot = await _cardCollection
          .where('userID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();
      dev.log('cards get success');
      return querySnapshot.docs
          .map((doc) => Card.fromJson(doc.data()))
          .toList();
    } catch (e) {
      dev.log('Cards get error');
      rethrow;
    }
  }
}
