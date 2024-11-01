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
      emit(TransactionLoading());
      if (event is TransactionAddEvent) {
        try {
          await _transactionRepository.addTransaction(
              transaction: event.transaction);
          emit(TransactionSuccess());
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
      if (event is TransactionFetchEvent) {
        try {
          final transactions = await _transactionRepository.getTransactions(
              userID: event.userID);
          emit(TransactionLoaded(transaction: transactions));
        } catch (e) {
          emit(const TransactionError(message: 'Error occurred!'));
        }
      }
    });
  }
}
