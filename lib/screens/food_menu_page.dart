import 'package:flutter/material.dart';
import 'package:hall_dining_management/database_helper.dart';

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({super.key});

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  String lunchMenu = '';
  String dinnerMenu = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    final menu = await DatabaseHelper().getMenuForToday();
    setState(() {
      lunchMenu = menu?['lunch'] ?? 'Not Set';
      dinnerMenu = menu?['dinner'] ?? 'Not Set';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Menu"),
        backgroundColor: Colors.blue[300],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 100,
                      color: Colors.blue[300],
                    ),
                    const SizedBox(height: 30),
                    Card(
                      child: ListTile(
                        title: const Text(
                          'Lunch Menu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(lunchMenu),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: ListTile(
                        title: const Text(
                          'Dinner Menu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(dinnerMenu),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
