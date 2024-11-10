part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionAddEvent extends TransactionEvent {
  final Transaction transaction;

  const TransactionAddEvent({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class TransactionFetchEvent extends TransactionEvent {
  final String userID;

  const TransactionFetchEvent({required this.userID});

  @override
  List<Object> get props => [userID];
}

class TransactionGetTotalsEvent extends TransactionEvent {
  final String userID;

  const TransactionGetTotalsEvent({required this.userID});

  @override
  List<Object> get props => [userID];
}

class TransactionDeleteEvent extends TransactionEvent {
  final String transactionID;

  const TransactionDeleteEvent({required this.transactionID});

  @override
  List<Object> get props => [transactionID];
}

class TransactionUpdateEvent extends TransactionEvent {
  final String transactionID;
  final Transaction transaction;

  const TransactionUpdateEvent({
    required this.transactionID,
    required this.transaction,
  });

  @override
  List<Object> get props => [transactionID, transaction];
}

class TransactionAnalysisDailyEvent extends TransactionEvent {
  final String userID;
  final DateTime dateTime;

  const TransactionAnalysisDailyEvent({
    required this.userID,
    required this.dateTime,
  });

  @override
  List<Object> get props => [userID, dateTime];
}
