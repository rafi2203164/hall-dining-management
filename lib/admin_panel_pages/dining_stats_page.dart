import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DiningStatsPage extends StatelessWidget {
  final int lunchUsers = 85;
  final int dinnerUsers = 120;

  const DiningStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Format current date as "Thursday, July 4, 2025"
    String todayDate = DateFormat('EEEE, MMMM d, y').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Dining Stats'),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.bar_chart, size: 100, color: Colors.blue[300]),
            SizedBox(height: 20),
            Text(
              'Today\'s Dining Stats',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300],
              ),
            ),
            SizedBox(height: 8),
            Text(
              todayDate,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 40),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.lunch_dining, color: Colors.blue[300]),
                title: Text('Lunch Users'),
                trailing: Text(
                  '$lunchUsers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.dinner_dining, color: Colors.blue[300]),
                title: Text('Dinner Users'),
                trailing: Text(
                  '$dinnerUsers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
