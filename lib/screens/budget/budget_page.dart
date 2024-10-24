import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'budget_add.dart';
import 'budget_details.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetGraph(),
          const SizedBox(height: 24),
          const Text(
            'My Budgets',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBudgetSection(
                    icon: Icons.shopping_cart,
                    title: 'Groceries',
                    spent: 425,
                    budget: 2910,
                  ),
                  const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.receipt_long,
                    title: 'Bills',
                    spent: 425,
                    budget: 2910,
                  ),
                  const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.medication,
                    title: 'Medicines',
                    spent: 500,
                    budget: 2000,
                  ),
                  const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.cast_for_education,
                    title: 'Education',
                    spent: 2905,
                    budget: 2910,
                  ),
                  const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.airplane_ticket,
                    title: 'Airplane',
                    spent: 1220,
                    budget: 2000,
                  ),const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.home,
                    title: 'Home',
                    spent: 1500,
                    budget: 2000,
                  ),const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.car_repair,
                    title: 'Car',
                    spent: 200,
                    budget: 2000,
                  ),const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.fitness_center,
                    title: 'GYM',
                    spent: 1800,
                    budget: 2000,
                  ),const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.spa,
                    title: 'SPA',
                    spent: 2400,
                    budget: 2000,
                  ),const SizedBox(height: 16),
                  _buildBudgetSection(
                    icon: Icons.cake,
                    title: 'Birthday',
                    spent: 2850,
                    budget: 2000,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BudgetAdd(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Add Budget',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBudgetGraph() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;

    List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    List<FlSpot> spots = List.generate(currentMonth, (index) {
      double usage = _getMonthlyUsage(index);
      return FlSpot(index.toDouble(), usage);
    });

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    monthNames[value.toInt()],
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.redAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.red.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMonthlyUsage(int monthIndex) {
    List<double> usageData = [
      120, 130, 140, 135, 150, 160,
      170, 180, 160, 150, 140, 200
    ];
    return usageData[monthIndex];
  }

  Widget _buildBudgetSection({
    required IconData icon,
    required String title,
    required double spent,
    required double budget,
  }) {
    return GestureDetector(
      onTap: () => _navigateToBudgetDetails(icon, title, spent, budget),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: spent / budget,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${(budget - spent).toStringAsFixed(0)} Left to spend'),
                        Text('\$${budget.toStringAsFixed(0)} Monthly budget'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToBudgetDetails(IconData icon, String title, double spent,
      double budget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BudgetDetailsPage(
              icon: icon,
              title: title,
              spent: spent,
              budget: budget,
            ),
      ),
    );
  }
}
