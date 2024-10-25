import 'package:file_picker/file_picker.dart';
import 'package:financial_app/components/dashed_border_button.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController typeController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  FilePickerResult? result;
  late PlatformFile file;
  String? selectedCategory;

  IconData? selectedIcon;

  final List<Map<String, String>> expenseCategories = [
    {'name': 'Food', 'icon': '🍎'},
    {'name': 'Sport', 'icon': '🏀'},
    {'name': 'Health', 'icon': '💊'},
    {'name': 'Transport', 'icon': '🚌'},
    {'name': 'Shopping', 'icon': '🛍️'},
    {'name': 'Kids', 'icon': '🧸'},
    {'name': 'Entertainment', 'icon': '🎮'},
    {'name': 'Other', 'icon': '🔍'},
  ];

  void selectIcon(String? type) {
    switch (type) {
      case 'Food':
        selectedIcon = Icons.fastfood;
        break;
      case 'Sport':
        selectedIcon = Icons.sports_basketball;
        break;
      case 'Health':
        selectedIcon = Icons.health_and_safety;
        break;
      case 'Transport':
        selectedIcon = Icons.directions_car;
        break;
      case 'Shopping':
        selectedIcon = Icons.shopping_cart;
        break;
      case 'Kids':
        selectedIcon = Icons.child_care;
        break;
      case 'Entertainment':
        selectedIcon = Icons.theaters;
        break;
      case 'Other':
        selectedIcon = Icons.category;
        break;
      default:
        selectedIcon = Icons.category;
    }
  }

  void pickFile() async {
    result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        file = result!.files.first;
      });
      // handle event
    } else {
      // User canceled the picker
    }
  }

  void showExpenseTypes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Select Expense Type',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: expenseCategories.map((category) {
                    return ChoiceChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(category['icon'] ?? ''),
                            const SizedBox(width: 6),
                            Text(category['name'] ?? ''),
                          ],
                        ),
                      ),
                      selected: selectedCategory == category['name'],
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedCategory = category['name'];
                            typeController.text = category['name']!;
                            selectIcon(selectedCategory);
                            Navigator.of(context).pop(); // Dismiss dialog
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      ' AMOUNT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      isReadOnly: false,
                      isObsecure: false,
                      label: '0.00',
                      suffixIcon: TextButton(
                        onPressed: () {
                          amountController.text = '';
                        },
                        child: const Text('Clear'),
                      ),
                      prefixText: 'Rs.',
                      controller: amountController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      ' EXPENSE TYPE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      isObsecure: false,
                      controller: typeController,
                      prefixIcon: selectedIcon,
                      isReadOnly: true,
                      label: 'Select Category',
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                      onTap: showExpenseTypes,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      ' DATE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      isReadOnly: true,
                      isObsecure: false,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          }
                        },
                        icon: const Icon(Icons.date_range),
                      ),
                      controller: dateController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      ' INVOICE(Optional)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    DashedButton(
                      onPressed: pickFile,
                      icon: Icons.add_circle,
                      text: 'Add Invoice',
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        result != null ? file.name : '',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SimpleButton(
              data: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
