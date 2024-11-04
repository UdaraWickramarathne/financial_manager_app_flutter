import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:financial_app/blocs/transaction/transaction_bloc.dart';
import 'package:financial_app/components/custome_snackbar.dart';
import 'package:financial_app/components/dropdown_button.dart';
import 'package:financial_app/components/services_icon.dart';
import 'package:financial_app/components/balance_card.dart';
import 'package:financial_app/components/transaction_tile.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:financial_app/screens/analysis/analysis_page.dart';
import 'package:financial_app/screens/budget/budget_page.dart';
import 'package:financial_app/screens/goals/goal_page.dart';
import 'package:financial_app/screens/notification/notification_page.dart';
import 'package:financial_app/screens/reminder/reminder_page.dart';
import 'package:financial_app/screens/transactions/transactions_page.dart';
import 'package:financial_app/services/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else if (hour < 20) {
      return 'Good Evening,';
    } else {
      return 'Good Night,';
    }
  }

  late TransactionBloc _transactionBloc;
  late AuthRepository _authRepository;

  @override
  void initState() {
    _transactionBloc = RepositoryProvider.of<TransactionBloc>(context);
    _authRepository = RepositoryProvider.of<AuthRepository>(context);
    _transactionBloc.add(TransactionFetchEvent(userID: _authRepository.userID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Lottie.asset(
                            'assets/onboard/dashboard_animation.json',
                            width: 120,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getGreeting()),
                          Text(
                            _authRepository.user!.name,
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CustomPageRoute(
                          page: const NotificationPage(),
                        ));
                      },
                      child: const Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                    const Text(''),
                    const Text(''),
                    const Text(''),
                  ],
                )
              ],
            ),
            const BalanaceCard(),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context).translate('services'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TransactionsPage(),
                            ));
                          },
                          backgroundColor: Colors.blue[100],
                          text: 'transactions',
                          icon: Icons.monetization_on_outlined,
                          foregroundColor: Colors.blue,
                        ),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AnalysisPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 251, 187, 251),
                          text: 'reports',
                          icon: Icons.file_copy_outlined,
                          foregroundColor:
                              const Color.fromARGB(255, 255, 98, 255),
                        ),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ReminderPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 251, 218, 187),
                          text: 'Reminders',
                          icon: Icons.alarm,
                          foregroundColor:
                              const Color.fromARGB(255, 253, 159, 71),
                        ),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const GoalPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 187, 251, 190),
                          text: 'goals',
                          icon: Icons.stairs_outlined,
                          foregroundColor:
                              const Color.fromARGB(255, 56, 250, 66),
                        ),
                        ServicesIcon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const BudgetPage(),
                            ));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 246, 187, 251),
                          text: 'budget',
                          icon: Icons.account_balance_wallet,
                          foregroundColor:
                              const Color.fromARGB(255, 146, 56, 250),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('recent_history'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const ChoiceBox(),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                bloc: _transactionBloc,
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionLoaded) {
                    return ListView.builder(
                      itemCount: state.transaction.length > 5
                          ? 5
                          : state.transaction.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transaction[index];
                        return TransactionTile(
                          id: transaction.id,
                          title: transaction.title,
                          createdAt: transaction.createdAt,
                          category: transaction.category,
                          amount: transaction.amount,
                          date: transaction.date,
                          isIncome: transaction.isIncome,
                          deleteFunction: (p0) {
                            _transactionBloc.add(
                              TransactionDeleteEvent(
                                transactionID: transaction.id,
                              ),
                            );
                            _transactionBloc.add(TransactionFetchEvent(
                                userID: _authRepository.userID));
                            showSuccessSnakBar();
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No transactions found.'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSuccessSnakBar() {
    CustomSnackBar.show(
      context,
      title: 'Deleted!!',
      message: 'Your transaction has been deleted successfully.',
      contentType: ContentType.success,
    );
  }
}
