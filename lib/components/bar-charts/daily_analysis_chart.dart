import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyAnalysisChart extends StatefulWidget {
  const DailyAnalysisChart({
    super.key,
  });

  @override
  State<DailyAnalysisChart> createState() => _DailyAnalysisChartState();
}

class _DailyAnalysisChartState extends State<DailyAnalysisChart> {
  DateTime selectedDate = DateTime.now();
  DateTime? _startOfWeek;
  DateTime? _endOfWeek;

  void _pickWeek(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        _startOfWeek =
            picked.subtract(Duration(days: picked.weekday % 7)); // Sunday
        _endOfWeek = _startOfWeek!.add(const Duration(days: 6)); // Saturday
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
    _endOfWeek = _startOfWeek!.add(const Duration(days: 6));
    //return selected date range
    print(
        '${DateFormat('yyyy-MM-dd').format(_startOfWeek!)}  -  ${DateFormat('yyyy-MM-dd').format(_endOfWeek!)}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceDim,
            borderRadius: BorderRadius.circular(25)),
        height: 350,
        child: Column(
          children: [
            TextButton(
              onPressed: () => _pickWeek(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline:
                        20.0, // Adjust this value to align text and icon properly
                    child: Text(
                      '${DateFormat('yyyy-MM-dd').format(_startOfWeek!)}  -  ${DateFormat('yyyy-MM-dd').format(_endOfWeek!)}',
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
                    baseline:
                        20.0, // The same baseline value as the Text widget
                    child: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.secondaryFixed,
                      size: 20,
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
                            case 10:
                              return const Text('10k');
                            case 20:
                              return const Text('20k');
                            case 30:
                              return const Text('30k');
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
                              return const Text('Mon');
                            case 1:
                              return const Text('Tue');
                            case 2:
                              return const Text('Wed');
                            case 3:
                              return const Text('Thu');
                            case 4:
                              return const Text('Fri');
                            case 5:
                              return const Text('Sat');
                            case 6:
                              return const Text('Sun');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(toY: 8, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: 30, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: 14, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: 15, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(toY: 13, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(toY: 10, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(toY: 16, color: Colors.greenAccent),
                        BarChartRodData(toY: 6, color: Colors.redAccent)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
