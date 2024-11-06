part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionEmpty extends TransactionState {}

final class TransactionSuccess extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionUpdateLoading extends TransactionState {}

final class TrnsactionUpdateSuccess extends TransactionState {}

final class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object> get props => [message];
}

final class TransactionUpdateError extends TransactionState {
  final String message;

  const TransactionUpdateError({required this.message});

  @override
  List<Object> get props => [message];
}

final class TransactionLoaded extends TransactionState {
  final List<Transaction> transaction;

  const TransactionLoaded({required this.transaction});
}
