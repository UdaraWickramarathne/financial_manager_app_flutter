import 'package:file_picker/file_picker.dart';
import 'package:financial_app/components/dashed_border_button.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/login_singup_button.dart';
import 'package:financial_app/services/header_clipper.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController typeController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  FilePickerResult? result;
  late PlatformFile file;
  String? selectedCategory;

  IconData? selectedIcon;

  final List<Map<String, String>> incomeCategories = [
    {'name': 'Salary', 'icon': '💼'},
    {'name': 'Business', 'icon': '🏢'},
    {'name': 'Investment', 'icon': '📈'},
    {'name': 'Freelance', 'icon': '💻'},
    {'name': 'Gift', 'icon': '🎁'},
    {'name': 'Other', 'icon': '🔍'},
  ];

  void selectIcon(String? type) {
    switch (type) {
      case 'Salary':
        selectedIcon = Icons.monetization_on;
        break;
      case 'Business':
        selectedIcon = Icons.business;
        break;
      case 'Investment':
        selectedIcon = Icons.show_chart;
        break;
      case 'Freelance':
        selectedIcon = Icons.work;
        break;
      case 'Gift':
        selectedIcon = Icons.card_giftcard;
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

  void showIncomeTypes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Select Income Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: incomeCategories.map((category) {
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(category['icon'] ?? ''),
                          const SizedBox(width: 4),
                          Text(category['name'] ?? ''),
                        ],
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
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text(
          'Add Income',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: HeaderClipper(),
                          child: Container(
                            height: 220,
                            color: const Color(0xFF0D47A1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 60),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 30,
                                  bottom: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      ' AMOUNT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
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
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      ' INCOME TYPE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(height: 10),
                                    InputField(
                                      isObsecure: false,
                                      controller: typeController,
                                      prefixIcon: selectedIcon,
                                      isReadOnly:
                                          true, // Make the field read-only since it's a selection
                                      label: 'Select Category',
                                      suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down_sharp),
                                      onTap: showIncomeTypes,
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      ' DATE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(height: 10),
                                    InputField(
                                      isReadOnly: true,
                                      isObsecure: false,
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          );

                                          if (pickedDate != null) {
                                            dateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
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
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
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
                                    const SizedBox(height: 180),
                                    SimpleButton(
                                      data: 'Save',
                                      onPressed: () {
                                        // Your save logic here
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
