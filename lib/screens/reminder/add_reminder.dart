import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_app/blocs/reminder/reminder_bloc.dart';
import 'package:financial_app/components/clickble_textfield.dart';
import 'package:financial_app/components/custome_snackbar.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/models/reminder.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  late ReminderBloc _reminderBloc;
  late AuthRepository _authRepository;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String? _selectedItem;
  final List<String> repeatOptions = [
    'Never',
    'Every minute',
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
        timeController.text = picked.format(context);
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
        selectedDate = pickedDate;
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  void initState() {
    _authRepository = RepositoryProvider.of<AuthRepository>(context);
    _reminderBloc = RepositoryProvider.of<ReminderBloc>(context);
    super.initState();
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _reminderBloc
                .add(ReminderFetchEvent(userID: _authRepository.userID));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocListener<ReminderBloc, ReminderState>(
        listener: (context, state) {
          if (state is ReminderLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (state is ReminderSuccess) {
            Navigator.pop(context);
            showSuccessSnakBar();
            clearFields();
          } else if (state is ReminderError) {
            Navigator.pop(context);
            showErrorSnackBar(state.message);
          }
        },
        child: Padding(
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
                        controller: titleController,
                        isReadOnly: false,
                        label: 'Add  Task Name..',
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Description (Optional)',
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
                                  label: DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now()),
                                  controller: dateController,
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
                                  label: TimeOfDay.now().format(context),
                                  controller: timeController,
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
                          hint: const Text('Select Repeat Frequancy'),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondaryFixed,
                            fontWeight: FontWeight.w400,
                          ),
                          value: _selectedItem,
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
                          dropdownColor:
                              Theme.of(context).colorScheme.surfaceDim,
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
                onPressed: () {
                  final title = titleController.text;
                  final date = dateController.text;
                  final time = timeController.text;
                  final description = descriptionController.text;
                  if (validateFields()) {
                    final reminder = Reminder(
                      userID: _authRepository.userID,
                      createdAt: Timestamp.now(),
                      date: date,
                      description:
                          description == '' ? 'Empty description' : description,
                      frequancy: _selectedItem!,
                      time: time,
                      title: title,
                    );
                    _reminderBloc.add(ReminderAddEvent(reminder: reminder));
                  }
                },
              )
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
      message: 'Your reminder has been added successfully.',
      contentType: ContentType.success,
    );
  }

  void showErrorSnackBar(String error) {
    CustomSnackBar.show(
      context,
      title: 'On Snap!',
      message: error,
      contentType: ContentType.failure,
    );
  }

  bool validateFields() {
    if (titleController.text.isEmpty) {
      showErrorSnackBar('Oops! Looks like your task lost its name.');
      return false;
    }
    if (dateController.text.isEmpty) {
      showErrorSnackBar('Date missing! Pick one!');
      return false;
    }
    if (timeController.text.isEmpty) {
      showErrorSnackBar('No time set? Pick a time!');
      return false;
    }
    if (_selectedItem == null) {
      showErrorSnackBar('Select a repeat frequency');
      return false;
    }
    return true;
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    setState(() {
      _selectedItem = null;
    });
  }
}
