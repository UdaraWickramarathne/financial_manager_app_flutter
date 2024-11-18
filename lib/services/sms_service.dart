import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:financial_app/blocs/transaction/transaction_bloc.dart';
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:intl/intl.dart';
import 'package:telephony/telephony.dart';
import 'dart:developer' as dev;

class SmsService {
  String textReceived = '';
  final TransactionBloc transactionBloc;
  final AuthRepository authRepository;
  final Telephony telephony = Telephony.instance;

  SmsService({
    required this.transactionBloc,
    required this.authRepository,
  });

  void startListening() {
    dev.log('Listing messages');
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) async {
        dev.log(message.address!);
        // if (message.address! == '8822') {
        RegExp regSampathCredited =
            RegExp(r'(\d+\.\d{2})\s*credited.*?for\s([a-zA-Z\s]+?)(?=\s*\d|$)');
        RegExp regSampathDebitedFor =
            RegExp(r'LKR\s([\d,]+\.\d{2})\s*debited.*?for\s([a-zA-Z0-9\s]+)');
        RegExp regSampathDebitedVia =
            RegExp(r'LKR\s([\d,]+\.\d{2})\s*debited.*?via\s([a-zA-Z0-9\s]+)');

        String? amount;
        String? description;
        bool isIncome = false;

        // Match the SMS with the regular expressions
        Match? matchCredit = regSampathCredited.firstMatch(message.body!);
        Match? matchDebitFor = regSampathDebitedFor.firstMatch(message.body!);
        Match? matchDebitVia = regSampathDebitedVia.firstMatch(message.body!);

        if (matchCredit != null) {
          amount = matchCredit.group(1)!.replaceAll(',', '');
          description = removeLastX(matchCredit.group(2)!);
          isIncome = true;
        } else if (matchDebitFor != null) {
          amount = matchDebitFor.group(1)!.replaceAll(',', '');
          description = removeLastX(matchDebitFor.group(2)!);
          isIncome = false;
        } else if (matchDebitVia != null) {
          amount = matchDebitVia.group(1)!.replaceAll(',', '');
          description = removeLastX(matchDebitVia.group(2)!);
          isIncome = false;
        }

        if (amount != null && description != null) {
          transactionBloc.add(
            TransactionAddEvent(
              transaction: Transaction(
                userID: authRepository.userID,
                title: description,
                category: 'Other',
                amount: double.parse(amount),
                date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                isIncome: isIncome,
                createdAt: Timestamp.now(),
              ),
            ),
          );
          await Future.delayed(const Duration(seconds: 1));
          transactionBloc
              .add(TransactionFetchEvent(userID: authRepository.userID));
        }
        // } else {
        //   dev.log('No transaction');
        // }
      },
      listenInBackground: false,
    );
  }

  String removeLastX(String text) {
    if (text.endsWith('X')) {
      return text.substring(0, text.length - 1);
    } else {
      return text;
    }
  }
}
