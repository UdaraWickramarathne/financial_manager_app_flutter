import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';

class BudgetAdd extends StatefulWidget {
  const BudgetAdd({super.key});

  @override
  State<BudgetAdd> createState() => _BudgetAddState();
}

class _BudgetAddState extends State<BudgetAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  String? _selectedItem;
  final List<String> repeatOptions = [
    'Weekly',
    'Monthly',
  ];

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
            'Add New Budget',
            style: TextStyle(fontSize: 20),
          ),
        ),
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
                    const Text(
                      ' BUDGET NAME',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      isObsecure: false,
                      controller: nameController,
                      isReadOnly: false,
                      label: 'Add budget name',
                    ),
                    const SizedBox(height: 20),
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
                      ' TIME PERIOD',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        elevation: 2,
                        hint: const Text('Select Time Period'),
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
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      ' EXPENSE CATEGORY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      isObsecure: false,
                      controller: typeController,
                      prefixIcon: selectedIcon,
                      isReadOnly: true,
                      label: 'Select Expense Category',
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                      onTap: showExpenseTypes,
                    ),
                  ],
                ),
              ),
            ),
            SimpleButton(
              data: 'Create Budget',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
