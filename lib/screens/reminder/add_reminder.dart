import 'package:financial_app/components/clickble_textfield.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? _selectedItem = 'Don\'t repeat';
  final List<String> repeatOptions = [
    'Don\'t repeat',
    'Everyday',
    'Every week',
    'Every month',
    'Every year',
  ];

  void _showTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              surface: Theme.of(context).colorScheme.surface,
              primary: const Color(0xFF456EFE),
              onSurface: Theme.of(context).colorScheme.secondaryFixed,
              secondary: const Color(0xFF456EFE),
              onSecondary: Colors.white,
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
    if (picked != null) {
      setState(() {
        timecontroller.text = picked.format(context);
      });
    }
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );
    if (pickedDate != null) {
      setState(() {
        datecontroller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Center(
          child: Text(
            'Add New Reminder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title Task',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    InputField(
                      isObsecure: false,
                      controller: taskController,
                      isReadOnly: false,
                      label: 'Add  Task Name..',
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Add Description..',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        fillColor: Theme.of(context).colorScheme.surfaceDim,
                        filled: true,
                        hintStyle: const TextStyle(
                          color: Color(0xFF626262),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF456EFE), width: 1.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              ClickbleTextfield(
                                prefixIcon: Icons.calendar_month,
                                label: 'Select Date',
                                controller: datecontroller,
                                onTap: () => _showDatePicker(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              ClickbleTextfield(
                                prefixIcon: Icons.access_time,
                                label: 'Select Time',
                                controller: timecontroller,
                                onTap: () => _showTimePicker(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Repeat',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        elevation: 2,
                        value: _selectedItem,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondaryFixed,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue!;
                          });
                        },
                        items: repeatOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 145, 145, 145)),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceDim,
                          prefixIcon: const Icon(
                            Icons.repeat,
                            color: Color(0xFF456EFE),
                          ),
                          labelText: "Repeat",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        dropdownColor: Theme.of(context).colorScheme.surfaceDim,
                        menuMaxHeight: 200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SimpleButton(
              data: 'Create',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
