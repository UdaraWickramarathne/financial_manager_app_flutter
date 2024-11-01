import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:file_picker/file_picker.dart';
import 'package:financial_app/blocs/transaction/transaction_bloc.dart';
import 'package:financial_app/components/custome_snackbar.dart';
import 'package:financial_app/components/dashed_border_button.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/models/transaction.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  FilePickerResult? result;
  late PlatformFile file;
  String? selectedCategory;

  IconData? selectedIcon;

  late TransactionBloc _transactionBloc;
  late AuthRepository _authRepository;

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
        selectedIcon = null;
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
                            categoryController.text = category['name']!;
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
    _transactionBloc = RepositoryProvider.of<TransactionBloc>(context);
    _authRepository = RepositoryProvider.of<AuthRepository>(context);
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ImageIcon(
              AssetImage('assets/icons/scan.ico'),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (state is TransactionSuccess) {
            Navigator.pop(context);
            showSuccessSnakBar();
            _clearInputFields();
          }
        },
        child: Padding(
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
                        controller: categoryController,
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
                        ' DESCRIPTION',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      InputField(
                        isObsecure: false,
                        controller: descriptionController,
                        isReadOnly: false,
                        label: 'Add a note or description',
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
                onPressed: () {
                  _transactionBloc.add(
                    TransactionAddEvent(
                      transaction: Transaction(
                        userID: _authRepository.userID,
                        title: descriptionController.text,
                        category: categoryController.text,
                        amount: double.parse(amountController.text),
                        date: dateController.text,
                        isIncome: false,
                        createdAt: Timestamp.now(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessSnakBar() {
    CustomSnackBar.show(
      context,
      title: 'Successfully!!',
      message: 'Your transaction has been added successfully.',
      contentType: ContentType.success,
    );
  }

  void _clearInputFields() {
    amountController.text = '';
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    categoryController.text = '';
    descriptionController.text = '';
    setState(() {
      selectIcon('default');
    });
  }
}
