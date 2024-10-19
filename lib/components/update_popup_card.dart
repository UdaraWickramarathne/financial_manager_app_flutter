import 'package:financial_app/components/input_field_bottom_border.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/services/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class UpdatePopupCard extends StatefulWidget {
  String id;
  double targetAmount;
  String deadLine;
  double notAchived;

  UpdatePopupCard({
    super.key,
    required this.id,
    required this.targetAmount,
    required this.deadLine,
    required this.notAchived,
  });

  @override
  State<UpdatePopupCard> createState() => _UpdatePopupCardState();
}

class _UpdatePopupCardState extends State<UpdatePopupCard> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController targetController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  FocusNode targetFocusNode = FocusNode();

  bool targetAmountIsReadOnly = true;
  @override
  void initState() {
    super.initState();
    targetController.text = widget.targetAmount.toString();
    dateController.text = widget.deadLine;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'update${widget.id}',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'New Car',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextField(
                        cursorColor: const Color(0xFF456EFE),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xFF456EFE),
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*')),
                        ],
                        controller: amountController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '0.00',
                          prefixText: 'LKR',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixStyle: TextStyle(
                            color: Color(0xFF456EFE),
                            fontSize: 25,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEFEFEF),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF456EFE)),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Target Amount: ',
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
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                            padding: const EdgeInsets.only(left: 85),
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
                    const SizedBox(height: 30),
                    SimpleButton(
                      data: 'Update Progress',
                      onPressed: () {},
                    )
                  ],
                ),
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
    dateController.dispose();
    amountController.dispose();

    super.dispose();
  }
}
