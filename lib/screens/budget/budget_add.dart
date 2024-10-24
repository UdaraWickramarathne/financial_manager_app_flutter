import 'package:flutter/material.dart';

class BudgetAdd extends StatefulWidget {
  const BudgetAdd({super.key});

  @override
  State<BudgetAdd> createState() => _BudgetAddState();
}

class _BudgetAddState extends State<BudgetAdd> {
  String? selectedIcon;
  String? selectedFrequency;
  String? selectedSavingMethod;

  final List<String> frequencies = ['Daily', 'Weekly', 'Monthly'];
  final List<String> savingMethods = ['Bank', 'Cash', 'Investment'];

  final List<IconData> iconList = [
    Icons.emoji_objects,
    Icons.local_grocery_store,
    Icons.fastfood,
    Icons.pets,
    Icons.trending_up,
    Icons.savings,
    Icons.airplane_ticket,
    Icons.home,
    Icons.car_repair,
    Icons.shopping_cart,
    Icons.library_books,
    Icons.movie,
    Icons.music_note,
    Icons.gamepad,
    Icons.camera_alt,
    Icons.palette,
    Icons.book,
    Icons.build,
    Icons.fitness_center,
    Icons.spa,
    Icons.cake,
    Icons.casino,
    Icons.local_florist,
    Icons.access_alarm,
    Icons.local_hospital,
    Icons.security,
    Icons.nature,
    Icons.work,
    Icons.person,
    Icons.monetization_on,
    Icons.pets,
    Icons.school,
    Icons.language,
    Icons.cast_for_education,
    Icons.travel_explore,
    Icons.trending_flat,
    Icons.wallet,
    Icons.assessment,
    Icons.share,
    Icons.lightbulb,
    Icons.notifications,
    Icons.people,
    Icons.radar,
    Icons.screenshot,
    Icons.thumb_up,
    Icons.access_time,
    Icons.build_circle,
  ];

  void _selectIcon() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Icon'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
              ),
              itemCount: iconList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIcon = iconList[index].toString();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(iconList[index], color: Colors.white),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _selectFrequency() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Budget Frequency'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: frequencies.map((frequency) {
                return ListTile(
                  title: Text(frequency),
                  onTap: () {
                    setState(() {
                      selectedFrequency = frequency;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _selectSavingMethod() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Saving Method'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: savingMethods.map((method) {
                return ListTile(
                  title: Text(method),
                  onTap: () {
                    setState(() {
                      selectedSavingMethod = method;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
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
        title: const Text('Add New Budget'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Write budget name',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectIcon,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      selectedIcon == null ? Icons.emoji_objects : Icons.check,
                      color: Colors.lightBlueAccent,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      selectedIcon ?? 'Select icon for budget',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Budget',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Set amount for budget',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Set amount for budget',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Add a description for budget',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectFrequency,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.repeat, color: Colors.lightBlueAccent),
                    const SizedBox(width: 10),
                    Text(
                      selectedFrequency ?? 'Select budget frequency',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectSavingMethod,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, color: Colors.lightBlueAccent),
                    const SizedBox(width: 10),
                    Text(
                      selectedSavingMethod ?? 'Select saving method',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Create Budget',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
