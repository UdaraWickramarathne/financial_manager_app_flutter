import 'package:financial_app/components/input_field_bottom_border.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransactionUpdatePopUp extends StatefulWidget {
  String id;
  String titile;
  double amount;
  String? selectedCategory;
  final Color? iconColor;
  final Color? containerColor;
  final IconData? icon;
  final bool isIncome;
  String date;
  TransactionUpdatePopUp(
      {super.key,
      required this.titile,
      required this.id,
      required this.selectedCategory,
      required this.amount,
      required this.iconColor,
      required this.containerColor,
      required this.icon,
      required this.isIncome,
      required this.date});

  @override
  State<TransactionUpdatePopUp> createState() => _TransactionUpdatePopUpState();
}

class _TransactionUpdatePopUpState extends State<TransactionUpdatePopUp> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  FocusNode targetFocusNode = FocusNode();
  late final List<String> _items;
  bool targetAmountIsReadOnly = true;
  bool isEditing = false;
  final TextEditingController _titleController = TextEditingController();

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        widget.titile = _titleController.text;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    targetController.text = widget.amount.toString();
    _titleController.text = widget.titile;
    dateController.text = widget.date;
    if (widget.isIncome) {
      _items = [
        'Salary',
        'Business',
        'Investment',
        'Freelance',
        'Gift',
        'Other',
      ];
    } else {
      _items = [
        'Sport',
        'Food',
        'Health',
        'Transport',
        'Shopping',
        'Kids',
        'Entertainment',
        'Other',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.containerColor,
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.iconColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: _toggleEditing,
                          child: isEditing
                              ? TextField(
                                  textAlign: TextAlign.center,
                                  controller: _titleController,
                                  onSubmitted: (value) {
                                    _toggleEditing();
                                  },
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                  autofocus: true,
                                )
                              : Text(
                                  widget.titile,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Amount: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 48),
                          child: InputFieldBottomBorder(
                            prefixText: 'LKR',
                            textAlign: TextAlign.end,
                            controller: targetController,
                            focusNode: targetFocusNode,
                            isReadOnly: targetAmountIsReadOnly,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormats: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*')),
                            ],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            targetAmountIsReadOnly = !targetAmountIsReadOnly;
                            if (!targetAmountIsReadOnly) {
                              targetFocusNode.requestFocus();
                            }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 3, left: 3),
                          child: Icon(
                            Icons.edit,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            elevation: 2,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125),
                            ),
                            value: widget.selectedCategory,
                            items: _items.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                widget.selectedCategory = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Deadline: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 42),
                          child: InputFieldBottomBorder(
                            textAlign: TextAlign.end,
                            controller: dateController,
                            isReadOnly: true,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
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
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 3, left: 3),
                          child: Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  SimpleButton(
                    data: 'Update',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    targetController.dispose();
    amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
