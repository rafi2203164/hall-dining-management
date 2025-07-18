import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildDashboardCard(
              context,
              icon: Icons.food_bank,
              label: 'Manage Menu',
              onTap: () {
                Navigator.pushNamed(context, '/manageMenu');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.account_circle,
              label: 'User Accounts',
              onTap: () {
                Navigator.pushNamed(context, '/userManagement');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.qr_code,
              label: 'Scan Logs',
              onTap: () {
                Navigator.pushNamed(context, '/scanLogs');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.settings,
              label: 'App Settings',
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.bar_chart,
              label: 'Dining Stats',
              onTap: () {
                Navigator.pushNamed(context, '/diningStats');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue[50],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.blue[300]),
              SizedBox(height: 20),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
