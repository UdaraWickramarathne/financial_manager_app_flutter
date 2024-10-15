import 'package:financial_app/components/input_field_bottom_border.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void showDetails() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                progressColor: const Color(0xFF456EFE),
                backgroundColor: const Color.fromARGB(255, 219, 228, 255),
                radius: 30,
                percent: 0.25,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                center: const Text('25%'),
              ),
              const Text(
                'New Car',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SofiaPro',
                ),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Target Amount:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFbabcbb),
                      ),
                    ),
                    Text('Rs.50000.00'),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Amount:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFbabcbb),
                      ),
                    ),
                    Text('Rs.20000.00'),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFbabcbb),
                      ),
                    ),
                    Text('2024/01/25'),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'End Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFbabcbb),
                      ),
                    ),
                    Text('2024/09/25'),
                  ],
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    padding:
                        WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.black),
                  ),
                )
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
        centerTitle: true,
        title: const Center(
          child: Text(
            'Your Goals',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
                icon: Icons.delete,
                backgroundColor: Colors.red.shade400,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              )
            ],
          ),
          child: GestureDetector(
            onTap: showDetails,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 145,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 70, 70, 70)
                              .withOpacity(0.1), // Shadow color
                          spreadRadius: 0, // How much the shadow spreads
                          blurRadius: 30, // Blur radius of the shadow
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 219, 228, 255),
                                ),
                                child: const Icon(
                                  Icons.car_rental_sharp,
                                  size: 50,
                                  color: Color(0xFF456EFE),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'New Car',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '25%',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF456EFE),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '13 months left',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFbabcbb),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        LinearPercentIndicator(
                          percent: 0.4,
                          progressColor: const Color(0xFF456EFE),
                          backgroundColor:
                              const Color.fromARGB(255, 219, 228, 255),
                          barRadius: const Radius.circular(20),
                          animation: true,
                          animationDuration: 1000,
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Rs.1200'),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      targetController.text = '25000.00';
                                      dateController.text = '2024-10-25';
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            'New Car',
                                            style: TextStyle(
                                              fontFamily: 'SofiaPro',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: TextField(
                                                  cursorColor:
                                                      const Color(0xFF456EFE),
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Color(0xFF456EFE),
                                                  ),
                                                  textAlignVertical:
                                                      TextAlignVertical.bottom,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: amountController,
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    hintText: '0.00',
                                                    prefixText: 'Rs.',
                                                    hintStyle: TextStyle(),
                                                    prefixStyle: TextStyle(
                                                      color: Color(0xFF456EFE),
                                                      fontSize: 30,
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFEFEFEF),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFF456EFE)),
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    'Target Amount: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child:
                                                        InputFieldBottomBorder(
                                                      prefixText: 'Rs',
                                                      textAlign: TextAlign.end,
                                                      controller:
                                                          targetController,
                                                      isReadOnly: false,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    'Deadline: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 45),
                                                  Expanded(
                                                    child:
                                                        InputFieldBottomBorder(
                                                      textAlign: TextAlign.end,
                                                      controller:
                                                          dateController,
                                                      isReadOnly: true,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 30),
                                              SimpleButton(
                                                data: 'Update',
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 219, 228, 255)),
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 5,
                                      bottom: 5,
                                    ),
                                  ),
                                  minimumSize:
                                      WidgetStateProperty.all(Size.zero),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Update Progress',
                                  style: TextStyle(
                                    color: Color(0xFF456EFE),
                                  ),
                                ),
                              ),
                              const Text('Rs.200000'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
