import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = [
      {'name': 'rafi', 'email': 'rafi123@gmail.com'},
      {'name': 'rafi', 'email': 'rafi123@gmail.com'},
      {'name': 'rafi', 'email': 'rafi123@gmail.com'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[300],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(user['name']!),
              subtitle: Text(user['email']!),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Removed ${user['name']}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
