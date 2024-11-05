import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_app/models/reminder.dart';
import 'package:financial_app/repositories/reminder/base_reminder_repository.dart';
import 'dart:developer' as developer;

class ReminderRepository extends BaseReminderRepository {
  final CollectionReference _reminderCollection =
      FirebaseFirestore.instance.collection('reminders');

  @override
  Future<void> addReminder({required Reminder reminder}) async {
    try {
      final doc = _reminderCollection.doc();
      reminder.id = doc.id;
      await doc.set(reminder.toJson());
      developer.log('goal add success');
    } catch (e) {
      developer.log('goal add error');
      rethrow;
    }
  }

  @override
  Future<void> deleteReminder({required String reminderID}) async {
    try {
      await _reminderCollection.doc(reminderID).delete();
      developer.log('reminder delete success');
    } catch (e) {
      developer.log('reminder delete error');
      rethrow;
    }
  }

  @override
  Future<List<Reminder>> getReminders({required String userID}) async {
    try {
      final quertSnapshot = await _reminderCollection
          .where('userID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();
      developer.log('reminders get success');
      return quertSnapshot.docs
          .map((doc) => Reminder.fromJson(doc.data()))
          .toList();
    } catch (e) {
      developer.log('reminders get error');
      rethrow;
    }
  }

  @override
  Future<void> updateReminder(
      {required String reminderID, required Reminder reminder}) async {
    try {
      developer.log(reminderID);
      await _reminderCollection
          .doc(reminderID)
          .set(reminder.toJson(), SetOptions(merge: true));
      developer.log('reminder updated');
    } catch (e) {
      developer.log('reminder fail to update ${e.toString()}');
      rethrow;
    }
  }
}
