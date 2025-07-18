import 'package:flutter/material.dart';

class ScanLogsPage extends StatelessWidget {
  final List<Map<String, String>> scanLogs = [
    {'name': 'rafi', 'time': '1:15 PM', 'type': 'Lunch'},
    {'name': 'rafi', 'time': '8:45 PM', 'type': 'Dinner'},
    {'name': 'rafi', 'time': '1:30 PM', 'type': 'Lunch'},
    {'name': 'rafi', 'time': '9:00 PM', 'type': 'Dinner'},
  ];

  ScanLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Logs'),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: scanLogs.length,
        itemBuilder: (context, index) {
          final log = scanLogs[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blue[300], size: 40),
              title: Text(
                log['name']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${log['type']} at ${log['time']}'),
              trailing: Icon(Icons.qr_code, color: Colors.blue[300]),
            ),
          );
        },
      ),
    );
  }
}
