import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:financial_app/repositories/transaction/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;
  final AuthRepository _authRepository;

  TransactionBloc(this._transactionRepository, this._authRepository)
      : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is TransactionAddEvent) {
        try {
          emit(TransactionLoading());
          await _transactionRepository.addTransaction(
              transaction: event.transaction);
          emit(TransactionSuccess());
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
      if (event is TransactionFetchEvent) {
        emit(TransactionFetchLoading());
        try {
          final transactions = await _transactionRepository.getTransactions(
            userID: event.userID,
          );
          if (transactions.isNotEmpty) {
            emit(TransactionLoaded(transactions: transactions));
          } else {
            emit(TransactionEmpty());
          }
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
      if (event is TransactionDeleteEvent) {
        try {
          await _transactionRepository.deleteTransaction(
              transactionID: event.transactionID);
          emit(TransactionDeleteSuccess());
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
      if (event is TransactionUpdateEvent) {
        try {
          emit(TransactionUpdateLoading());
          await _transactionRepository.updateTransaction(
            transactionID: event.transactionID,
            transaction: event.transaction,
          );
          await Future.delayed(const Duration(milliseconds: 500));
          emit(TrnsactionUpdateSuccess());
        } catch (e) {
          await Future.delayed(const Duration(milliseconds: 500));
          emit(const TransactionUpdateError(message: 'Error occurred!'));
        }
      }
      if (event is TransactionGetTotalsEvent) {
        try {
          emit(TransactionGetTotalLoading());
          final totalIncomeExpense = await _transactionRepository
              .getTotalIncomeExpense(userID: event.userID);
          _authRepository.user!.totalIncome =
              totalIncomeExpense['totalIncome'] ?? 0.0;
          _authRepository.user!.totalExpense =
              totalIncomeExpense['totalExpense'] ?? 0.0;
          emit(TransactionGetTotalLoaded(
              totalIncomeExpense: totalIncomeExpense));
        } catch (e) {
          emit(const TransactionGetTotalError(message: 'Error occured'));
        }
      }
      if (event is TransactionAnalysisDailyEvent) {
        try {
          emit(TransactionAnalysisDailyLoading());
          await Future.delayed(const Duration(seconds: 1));
          final result = await _transactionRepository.getWeeklyTotals(
              userID: event.userID, startDate: event.dateTime);
          emit(TransactionAnalysisDailyLoaded(weelkyTotals: result));
        } catch (e) {
          emit(const TransactionAnalysisDailyError(message: 'Error occured'));
        }
      }
    });
  }
}
