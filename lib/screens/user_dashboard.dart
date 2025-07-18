import 'package:flutter/material.dart';
import 'package:hall_dining_management/screens/buy_token_page.dart';
import 'package:hall_dining_management/screens/use_token_page.dart';
import 'package:hall_dining_management/screens/user_profile_page.dart';

class UserDashboard extends StatelessWidget {
  final String userEmail;

  const UserDashboard({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final String username = 'rafi';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome $username!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                _buildStatCard('Credits', '120'),
                const SizedBox(width: 16),
                _buildStatCard('Tokens', '3'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BuyTokenPage(userEmail: userEmail),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[50],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Buy Token'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => UseTokenPage(userEmail: userEmail),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Use Token'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.restaurant_menu),
                  iconSize: 32,
                  tooltip: "View Menu",
                  onPressed: () => Navigator.pushNamed(context, '/foodMenu'),
                ),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  iconSize: 32,
                  tooltip: "Scan QR",
                  onPressed: () => Navigator.pushNamed(context, '/qrScanner'),
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  iconSize: 32,
                  tooltip: "Profile",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UserProfilePage(userEmail: userEmail),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  iconSize: 32,
                  tooltip: "Settings",
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(label, style: const TextStyle(fontSize: 18)),
              Text(value, style: const TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
