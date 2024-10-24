import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class WeeklyAnalysisChart extends StatefulWidget {
  const WeeklyAnalysisChart({super.key});

  @override
  State<WeeklyAnalysisChart> createState() => _WeeklyAnalysisChartState();
}

class _WeeklyAnalysisChartState extends State<WeeklyAnalysisChart> {
  DateTime selectedDate = DateTime.now();
  List<String> weeks = [];
  late int year;

  _WeeklyAnalysisChartState() {
    year = selectedDate.year;
  }

  Future<void> _selectMonthYear(BuildContext context) async {
    final DateTime? picked = await showMonthYearPicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF456EFE), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Theme.of(context)
                  .colorScheme
                  .secondaryFixed, // body text color
              secondary: const Color(0xFF456EFE),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF456EFE), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        year = picked.year;
        selectedDate = picked;
        weeks.clear();
        weeks = _getWeeksOfMonth(picked);

        //return weeks of month
        print('year $year');
        print(weeks.map((week) => Text(week)).toList());
      });
    }
  }

  List<String> _getWeeksOfMonth(DateTime month) {
    List<String> weeks = [];
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    DateTime lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    DateTime startOfWeek = firstDayOfMonth;
    while (startOfWeek.isBefore(lastDayOfMonth)) {
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
      if (endOfWeek.isAfter(lastDayOfMonth)) {
        endOfWeek = lastDayOfMonth;
      }
      weeks.add(
          '${DateFormat('dd MMM').format(startOfWeek)} - ${DateFormat('dd MMM').format(endOfWeek)}');
      startOfWeek = endOfWeek.add(
        const Duration(days: 1),
      );
    }

    return weeks;
  }

  @override
  void initState() {
    super.initState();
    weeks = _getWeeksOfMonth(selectedDate);

    //return weeks of month
    print('year $year');
    print(weeks.map((week) => Text(week)).toList());
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
              onPressed: () => _selectMonthYear(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline:
                        20.0, // Adjust this value to align text and icon properly
                    child: Text(
                      DateFormat('yyyy MMMM').format(selectedDate),
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
                              return const Text('W1');
                            case 1:
                              return const Text('W2');
                            case 2:
                              return const Text('W3');
                            case 3:
                              return const Text('W4');
                            case 4:
                              return const Text('W5');

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
                        BarChartRodData(toY: 4, color: Colors.greenAccent),
                        BarChartRodData(toY: 3, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: 20, color: Colors.greenAccent),
                        BarChartRodData(toY: 3, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: 20, color: Colors.greenAccent),
                        BarChartRodData(toY: 16, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: 3, color: Colors.greenAccent),
                        BarChartRodData(toY: 10, color: Colors.redAccent)
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(toY: 9, color: Colors.greenAccent),
                        BarChartRodData(toY: 10, color: Colors.redAccent)
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
