import 'package:financial_app/components/goal_card.dart';
import 'package:financial_app/screens/goals/add_goal_page.dart';
import 'package:flutter/material.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
          ),
        ],
        centerTitle: true,
        title: const Center(
          child: Text(
            'Your Goals',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddGoalPage(),
              ));
        },
        backgroundColor: const Color(0xFF456EFE),
        shape: const CircleBorder(),
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: const Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              GoalCard(
                id: '1',
              ),
              GoalCard(
                id: '2',
              ),
            ],
          )),
    );
  }
}
