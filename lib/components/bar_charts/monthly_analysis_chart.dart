import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyAnalysisChart extends StatefulWidget {
  const MonthlyAnalysisChart({super.key});

  @override
  State<MonthlyAnalysisChart> createState() => _MonthlyAnalysisChartState();
}

class _MonthlyAnalysisChartState extends State<MonthlyAnalysisChart> {
  DateTime selectedYear = DateTime.now();
  bool isJanJunSelected = true;

  // Sample income and expense data for both halves of the year
  final List<double> incomesJanJun = [
    4000,
    3000,
    2000,
    5000,
    4500,
    3500
  ]; // Income data for Jan-Jun
  final List<double> expensesJanJun = [
    2000,
    1500,
    1000,
    2500,
    2000,
    1200
  ]; // Expense data for Jan-Jun
  final List<double> incomesJulDec = [
    5000,
    6000,
    4500,
    7000,
    8000,
    9000
  ]; // Income data for Jul-Dec
  final List<double> expensesJulDec = [
    3000,
    2500,
    2000,
    4000,
    3500,
    3000
  ]; // Expense data for Jul-Dec

  @override
  void initState() {
    super.initState();
  }

  void _toggleButtons() {
    setState(() {
      isJanJunSelected = !isJanJunSelected; // Swap the selection
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceDim,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 350,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (!isJanJunSelected) _toggleButtons();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        isJanJunSelected ? const Color(0xFF456EFE) : null),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(6)),
                    minimumSize: const WidgetStatePropertyAll(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Jan-Jun',
                    style: TextStyle(
                      color: isJanJunSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Select Year"),
                          content: SizedBox(
                            width: 300,
                            height: 300,
                            child: YearPicker(
                              firstDate: DateTime(DateTime.now().year - 100, 1),
                              lastDate: DateTime.now(),
                              selectedDate: selectedYear,
                              onChanged: (DateTime dateTime) {
                                setState(() {
                                  selectedYear = dateTime;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 20.0,
                        child: Text(
                          DateFormat('yyyy').format(selectedYear),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondaryFixed,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 20.0,
                        child: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).colorScheme.secondaryFixed,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isJanJunSelected) _toggleButtons();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        isJanJunSelected ? null : const Color(0xFF456EFE)),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(6)),
                    minimumSize: const WidgetStatePropertyAll(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Jul-Dec',
                    style: TextStyle(
                      color: isJanJunSelected ? Colors.grey : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: BarChart(
                  key: ValueKey<bool>(isJanJunSelected),
                  BarChartData(
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('0');
                              case 2000:
                                return const Text('2k');
                              case 4000:
                                return const Text('4k');
                              case 6000:
                                return const Text('6k');
                              case 8000:
                                return const Text('8k');
                              default:
                                return const Text('');
                            }
                          },
                          interval: 10,
                          reservedSize: 28,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => isJanJunSelected
                              ? getJanToJunTitles(value, meta)
                              : getJulToDecTitles(value, meta),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: isJanJunSelected
                        ? List.generate(
                            6,
                            (index) {
                              return BarChartGroupData(x: index, barRods: [
                                BarChartRodData(
                                    toY: incomesJanJun[index],
                                    color: Colors.greenAccent), // Income
                                BarChartRodData(
                                    toY: expensesJanJun[index],
                                    color: Colors.redAccent), // Expense
                              ]);
                            },
                          )
                        : List.generate(
                            6,
                            (index) {
                              return BarChartGroupData(x: index, barRods: [
                                BarChartRodData(
                                    toY: incomesJulDec[index],
                                    color: Colors.greenAccent), // Income
                                BarChartRodData(
                                    toY: expensesJulDec[index],
                                    color: Colors.redAccent), // Expense
                              ]);
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getJanToJunTitles(value, meta) {
    switch (value.toInt()) {
      case 0:
        return const Text('Jan');
      case 1:
        return const Text('Feb');
      case 2:
        return const Text('Mar');
      case 3:
        return const Text('Apr');
      case 4:
        return const Text('May');
      case 5:
        return const Text('Jun');
      default:
        return const Text('');
    }
  }

  Widget getJulToDecTitles(value, meta) {
    switch (value.toInt()) {
      case 0:
        return const Text('Jul');
      case 1:
        return const Text('Aug');
      case 2:
        return const Text('Sep');
      case 3:
        return const Text('Oct');
      case 4:
        return const Text('Nov');
      case 5:
        return const Text('Dec');
      default:
        return const Text('');
    }
  }
}
