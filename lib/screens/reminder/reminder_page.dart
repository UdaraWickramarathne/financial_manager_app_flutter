import 'package:financial_app/components/reminder_card.dart';
import 'package:financial_app/screens/reminder/add_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  double _borderRadius = 15.0;
  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
    _slidableController.animation.addListener(() {
      if (_slidableController.animation.value > 0) {
        setState(() {
          _borderRadius = 0.0;
        });
      } else {
        setState(() {
          _borderRadius = 15.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
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
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF456EFE),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Your Reminders",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddReminder(),
              ));
        },
        backgroundColor: const Color(0xFF456EFE),
        shape: const CircleBorder(),
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              color: Color(0xFF456EFE),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('MMM yyyy').format(selectedDate),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectMonthYear(context),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Event',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          const ReminderCard(),
          const ReminderCard(),
          const ReminderCard(),
        ],
      ),
    );
  }
}
