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

  List<int> yAxisValues = [];

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
    //calculate y axix parts values
    yAxisValues = divideIntoFourParts(10000);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceDim,
            borderRadius: BorderRadius.circular(25)),
        height: 450,
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
                            case int value when value == yAxisValues[0]:
                              return Text(
                                '${yAxisValues[0] % 1000 == 0 ? yAxisValues[0] ~/ 1000 : yAxisValues[0] / 1000}k',
                              );
                            case int value when value == yAxisValues[1]:
                              return Text(
                                '${yAxisValues[1] % 1000 == 0 ? yAxisValues[1] ~/ 1000 : yAxisValues[1] / 1000}k',
                              );
                            case int value when value == yAxisValues[2]:
                              return Text(
                                '${yAxisValues[2] % 1000 == 0 ? yAxisValues[2] ~/ 1000 : yAxisValues[2] / 1000}k',
                              );
                            case int value when value == yAxisValues[3]:
                              return Text(
                                '${yAxisValues[3] % 1000 == 0 ? yAxisValues[3] ~/ 1000 : yAxisValues[3] / 1000}k',
                              );
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
                        BarChartRodData(toY: 3000, color: Colors.greenAccent),
                        BarChartRodData(toY: 2600, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: 9000, color: Colors.greenAccent),
                        BarChartRodData(toY: 7000, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: 6200, color: Colors.greenAccent),
                        BarChartRodData(toY: 6544, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: 7500, color: Colors.greenAccent),
                        BarChartRodData(toY: 0, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(toY: 1500, color: Colors.greenAccent),
                        BarChartRodData(toY: 8000, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(toY: 0, color: Colors.greenAccent),
                        BarChartRodData(toY: 6733, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(toY: 1400, color: Colors.greenAccent),
                        BarChartRodData(toY: 8000, color: Colors.redAccent)
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

  // * Method for calculate Y axix AxisTitles

  List<int> divideIntoFourParts(int number) {
    // Find the closest higher multiple of 10000
    int closestHigherMultiple = (number / 10000).ceil() * 10000;

    // Divide the closest higher multiple by 4
    int part = closestHigherMultiple ~/
        4; // Integer division to get the base value for each part

    // Generate the 4 parts using the base part value
    return [
      part,
      part * 2,
      part * 3,
      closestHigherMultiple // The last part is the closest higher multiple itself
    ];
  }
}
