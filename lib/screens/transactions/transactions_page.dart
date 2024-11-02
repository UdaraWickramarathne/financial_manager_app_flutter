import 'package:financial_app/blocs/transaction/transaction_bloc.dart';
import 'package:financial_app/components/transaction_tile.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:financial_app/screens/transactions/transaction_type_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late TransactionBloc _transactionBloc;
  late AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _transactionBloc = RepositoryProvider.of<TransactionBloc>(context);
    _authRepository = RepositoryProvider.of<AuthRepository>(context);
    _transactionBloc.add(TransactionFetchEvent(userID: _authRepository.userID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "All Transactions",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionTypePage(),
              ));
        },
        backgroundColor: const Color(0xFF456EFE),
        shape: const CircleBorder(),
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onRefresh: () async {
          _transactionBloc
              .add(TransactionFetchEvent(userID: _authRepository.userID));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<TransactionBloc, TransactionState>(
            bloc: _transactionBloc,
            builder: (context, state) {
              if (state is TransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TransactionLoaded) {
                return ListView.builder(
                  itemCount: state.transaction.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transaction[index];
                    return TransactionTile(
                      id: transaction.id,
                      title: transaction.title,
                      category: transaction.category,
                      amount: transaction.amount,
                      date: transaction.date,
                      isIncome: transaction.isIncome,
                    );
                  },
                );
              }
              return const Center(child: Text('No transactions found.'));
            },
          ),
        ),
      ),
    );
  }
}
