import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hall_dining_management/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool darkModeEnabled = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
            activeColor: Colors.blue[300],
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: darkModeEnabled,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
            activeColor: Colors.blue[300],
          ),
          Divider(height: 40, thickness: 1),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.blue[300]),
            title: Text('About'),
            subtitle: Text('Version 1.0.0\nHall Dining Management System'),
            isThreeLine: true,
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (Route<dynamic> route) => false,
              );

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Logged out')));
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
