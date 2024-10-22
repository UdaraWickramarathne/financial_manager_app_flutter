import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyAnalysisChart extends StatefulWidget {
  const YearlyAnalysisChart({super.key});

  @override
  State<YearlyAnalysisChart> createState() => _YearlyAnalysisChartState();
}

class _YearlyAnalysisChartState extends State<YearlyAnalysisChart> {
  final List<double> incomes = [
    4000,
    3000,
    2000,
    5000,
    4500,
  ];
  final List<double> expenses = [
    2000,
    1500,
    1000,
    2500,
    2000,
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25)),
        height: 350,
        child: Column(
          children: [
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline:
                        20.0, // Adjust this value to align text and icon properly
                    child: Text(
                      'Last 5 Years',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondaryFixed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BarChart(
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
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('2010');
                            case 1:
                              return const Text('2021');
                            case 2:
                              return const Text('2022');
                            case 3:
                              return const Text('2023');
                            case 4:
                              return const Text('2024');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: List.generate(
                    5,
                    (index) {
                      return BarChartGroupData(x: index, barRods: [
                        BarChartRodData(
                            toY: incomes[index],
                            color: Colors.greenAccent), // Income
                        BarChartRodData(
                            toY: expenses[index],
                            color: Colors.redAccent), // Expense
                      ]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
