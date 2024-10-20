import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyAnalysisChart extends StatelessWidget {
  const DailyAnalysisChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25)),
      height: 300,
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
                    return const Text('Rs.0');
                  case 10:
                    return const Text('Rs.10k');
                  case 20:
                    return const Text('Rs.20k');
                  default:
                    return const Text('');
                }
              },
              interval: 10,
              reservedSize: 45,
            )),
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
    );
  }
}
