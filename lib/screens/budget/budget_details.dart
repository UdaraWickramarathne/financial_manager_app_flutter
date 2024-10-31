import 'package:flutter/material.dart';

class BudgetDetailsPage extends StatefulWidget {
  final IconData icon;
  final String title;
  final double spent;
  final double budget;

  const BudgetDetailsPage({
    super.key,
    required this.icon,
    required this.title,
    required this.spent,
    required this.budget,
  });

  @override
  State<BudgetDetailsPage> createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage> {
  bool _isEditing = false;

  late TextEditingController _amountController;
  late TextEditingController budgetController;
  late TextEditingController _descriptionController;
  String _selectedRepeat = 'Monthly';
  String _selectedAccount = 'Google Pay';

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '\$${widget.spent}');
    budgetController = TextEditingController(text: '\$${widget.budget}');
    _descriptionController = TextEditingController(text: 'Expense details');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(widget.icon, color: Colors.blue, size: 40),
                    const SizedBox(width: 8),
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(_isEditing ? Icons.check : Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Amount Field
            _buildEditableField(
              label: 'Budget',
              controller: budgetController,
              isEditable: _isEditing,
            ),
            const SizedBox(height: 16),
            _buildEditableField(
              label: 'Amount',
              controller: _amountController,
              isEditable: _isEditing,
            ),
            const SizedBox(height: 16),

            // Description Field
            _buildEditableField(
              label: 'Description',
              controller: _descriptionController,
              isEditable: _isEditing,
            ),
            const SizedBox(height: 16),

            // Repeat Dropdown
            _buildDropdownField(
              label: 'Repeat',
              value: _selectedRepeat,
              isEditable: _isEditing,
              items: ['Daily', 'Weekly', 'Monthly'],
              onChanged: (newValue) {
                setState(() {
                  _selectedRepeat = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Account Dropdown
            _buildDropdownField(
              label: 'Account',
              value: _selectedAccount,
              isEditable: _isEditing,
              items: ['Google Pay', 'PayPal', 'Bank Transfer'],
              onChanged: (newValue) {
                setState(() {
                  _selectedAccount = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditable,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEditable,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required bool isEditable,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: isEditable ? onChanged : null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
