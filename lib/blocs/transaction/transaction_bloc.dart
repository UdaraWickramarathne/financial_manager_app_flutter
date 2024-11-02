import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/transaction/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc(this._transactionRepository) : super(TransactionInitial()) {
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
        emit(TransactionLoading());
        try {
          final transactions = await _transactionRepository.getTransactions(
              userID: event.userID);
          emit(TransactionLoaded(transaction: transactions));
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
      if (event is TransactionDeleteEvent) {
        try {
          await _transactionRepository.deleteTransaction(
              transactionID: event.transactionID);
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
      if(event is TransactionUpdateEvent){
        try {
          await _transactionRepository.updateTransaction(transactionID: event.transactionID,transaction: event.transaction);
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
    });
  }
}
