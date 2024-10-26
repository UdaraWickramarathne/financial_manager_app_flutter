import 'package:financial_app/components/input_field_bottom_border.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class UpdateBudgetPopup extends StatefulWidget {
  String id;
  String titile;
  double budgetAmount;
  String? selectedPeriod = 'Weekly';
  UpdateBudgetPopup({
    super.key,
    required this.titile,
    required this.id,
    required this.selectedPeriod,
    required this.budgetAmount,
  });

  @override
  State<UpdateBudgetPopup> createState() => _UpdateBudgetPopupState();
}

class _UpdateBudgetPopupState extends State<UpdateBudgetPopup> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController targetController = TextEditingController();

  FocusNode targetFocusNode = FocusNode();

  final List<String> _items = ['Weekly', 'Monthly'];

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
    targetController.text = widget.budgetAmount.toString();

    _titleController.text = widget.titile;
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
                  Center(
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
                  const SizedBox(height: 20),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Budget Amount: ',
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
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Time Period: ',
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
                            value: widget.selectedPeriod,
                            items: _items.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                widget.selectedPeriod = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  SimpleButton(
                    data: 'Update Budget',
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
