import 'package:financial_app/components/bar-charts/daily_analysis_chart.dart';
import 'package:financial_app/components/bar-charts/monthly_analysis_chart.dart';
import 'package:financial_app/components/bar-charts/weekly_analysis_chart.dart';
import 'package:financial_app/components/bar-charts/yearly_analysis_chart.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:financial_app/services/generate_pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  DateTime endDate = DateTime.now();
  late DateTime startDate;
  late AuthRepository _authRepository;
  double incomeBal = 0.0;
  double expenseBal = 0.0;

  @override
  void initState() {
    super.initState();
    startDate = endDate.subtract(const Duration(days: 30));
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController();
    _tabController.addListener(() {
      setState(() {});
    });
    _authRepository = RepositoryProvider.of<AuthRepository>(context);
    incomeBal = _authRepository.user!.totalIncome;
    expenseBal = _authRepository.user!.totalExpense;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF456EFE),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          "Analysis",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF456EFE),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rs.${incomeBal.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "(Monthly Income)",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs.${expenseBal.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "(Monthly Expense)",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: DefaultTabController(
                      animationDuration: const Duration(milliseconds: 600),
                      length: 4, // Number of tabs
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceDim,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          dividerHeight: 0,
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicator: BoxDecoration(
                            color: const Color(
                                0xFF456EFE), // Color of the selected tab
                            borderRadius: BorderRadius.circular(
                                30.0), // Rounded corners for selected tab
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: const [
                            SizedBox(
                              width: 80,
                              child: Tab(text: "Daily"),
                            ),
                            SizedBox(
                              width: 80,
                              child: Tab(text: "Weekly"),
                            ),
                            SizedBox(
                              width: 80,
                              child: Tab(text: "Monthly"),
                            ),
                            SizedBox(
                              width: 80,
                              child: Tab(text: "Year"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 450,
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        DailyAnalysisChart(),
                        WeeklyAnalysisChart(),
                        MonthlyAnalysisChart(),
                        YearlyAnalysisChart(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'End Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 20.0,
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(startDate),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).colorScheme.secondaryFixed,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 20.0,
                          child: GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 250,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                        initialDateTime: startDate,
                                        maximumDate: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                        backgroundColor: Colors.transparent,
                                        onDateTimeChanged: (value) {
                                          setState(() {
                                            startDate = value;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.calendar_month,
                              color:
                                  Theme.of(context).colorScheme.secondaryFixed,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 20.0,
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(endDate),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).colorScheme.secondaryFixed,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 20.0,
                          child: GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 250,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                        initialDateTime: endDate,
                                        maximumDate: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                        backgroundColor: Colors.transparent,
                                        onDateTimeChanged: (value) {
                                          setState(() {
                                            endDate = value;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.calendar_month,
                              color:
                                  Theme.of(context).colorScheme.secondaryFixed,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: SimpleButton(
              data: 'Generate Report',
              onPressed: () => onGenerateReportPressed(context),
            ),
          )
        ],
      ),
    );
  }

  void onGenerateReportPressed(BuildContext context) {
    //dummy data for pdf

    List<Map<String, dynamic>> incomeData = [
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      {'date': '2024-10-01', 'amount': 1000, 'description': 'Salary'},
      // Add more income data
    ];

    List<Map<String, dynamic>> expenseData = [
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      {'date': '2024-10-02', 'amount': 200, 'description': 'Groceries'},
      // Add more expense data
    ];

    String startDate = '2024-10-01';
    String endDate = '2024-10-31';

    generateAndShowPdf(context, incomeData, expenseData, startDate, endDate);
  }
}
