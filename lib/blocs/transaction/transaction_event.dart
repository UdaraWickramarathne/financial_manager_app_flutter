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

class TransactionDelete extends TransactionEvent {
  final String transactionID;

  const TransactionDelete({required this.transactionID});

  @override
  List<Object> get props => [transactionID];
}
