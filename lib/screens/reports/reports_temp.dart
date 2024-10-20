import 'package:financial_app/components/bar%20charts/daily_analysis_chart.dart';
import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF456EFE),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Analysis",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top balance and expense info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF456EFE),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Income",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "\$7,783.00",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Expense",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "-\$1,187.40",
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "30% of Your Expenses, Looks Good.",
                      style: TextStyle(color: Colors.white),
                    ),
                    CircularProgressIndicator(
                      value: 0.3,
                      backgroundColor: Colors.white30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // TabBar (Daily, Weekly, Monthly, Year)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DefaultTabController(
                  length: 4, // Number of tabs
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Background color of the whole tab bar
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TabBar(
                      dividerHeight: 0,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
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
                const SizedBox(height: 20),
                const DailyAnalysisChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
