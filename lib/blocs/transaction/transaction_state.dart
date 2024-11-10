part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

// * TRANSACTION ADD STATES
final class TransactionSuccess extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object> get props => [message];
}

// * TRANSACTION FETCH STATES

final class TransactionEmpty extends TransactionState {}

final class TransactionFetchLoading extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoaded({required this.transactions});
}

// * TRANSACTION DELETE STATES

final class TransactionDeleteSuccess extends TransactionState {}

// * TRANSACTION UPDATE STATES

final class TransactionUpdateLoading extends TransactionState {}

final class TrnsactionUpdateSuccess extends TransactionState {}

final class TransactionUpdateError extends TransactionState {
  final String message;

  const TransactionUpdateError({required this.message});

  @override
  List<Object> get props => [message];
}

// * TRANSACTION GET TOTAL STATES

final class TransactionGetTotalLoading extends TransactionState {}

final class TransactionGetTotalLoaded extends TransactionState {
  final Map<String, double> totalIncomeExpense;

  const TransactionGetTotalLoaded({required this.totalIncomeExpense});

  @override
  List<Object> get props => [totalIncomeExpense];
}

final class TransactionGetTotalError extends TransactionState {
  final String message;

  const TransactionGetTotalError({required this.message});

  @override
  List<Object> get props => [message];
}

// * TRANSACTION DAILY ANALYSIS STATES

final class TransactionAnalysisDailyLoaded extends TransactionState {
  final Map<String, dynamic> weelkyTotals;

  const TransactionAnalysisDailyLoaded({required this.weelkyTotals});

  @override
  List<Object> get props => [weelkyTotals];
}

final class TransactionAnalysisDailyLoading extends TransactionState {}

final class TransactionAnalysisDailyError extends TransactionState {
  final String message;

  const TransactionAnalysisDailyError({required this.message});

  @override
  List<Object> get props => [message];
}
