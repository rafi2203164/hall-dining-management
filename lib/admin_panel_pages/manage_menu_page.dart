import 'package:flutter/material.dart';
import 'package:hall_dining_management/database_helper.dart';

class ManageMenuPage extends StatefulWidget {
  const ManageMenuPage({super.key});

  @override
  State<ManageMenuPage> createState() => _ManageMenuPageState();
}

class _ManageMenuPageState extends State<ManageMenuPage> {
  final _lunchController = TextEditingController();
  final _dinnerController = TextEditingController();

  Future<void> _saveMenu() async {
    final lunch = _lunchController.text.trim();
    final dinner = _dinnerController.text.trim();

    if (lunch.isEmpty || dinner.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both lunch and dinner menus.'),
        ),
      );
      return;
    }

    await DatabaseHelper().setMenuForToday(lunch, dinner);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Menu updated successfully!')));

    _lunchController.clear();
    _dinnerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Today's Menu"),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.edit_calendar, size: 100, color: Colors.blue[300]),
            const SizedBox(height: 20),
            TextField(
              controller: _lunchController,
              decoration: const InputDecoration(
                labelText: 'Lunch Menu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dinnerController,
              decoration: const InputDecoration(
                labelText: 'Dinner Menu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Menu',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
