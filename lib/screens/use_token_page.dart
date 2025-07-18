import 'package:flutter/material.dart';
import 'package:hall_dining_management/database_helper.dart';
import 'package:hall_dining_management/screens/buy_token_page.dart';

class UseTokenPage extends StatefulWidget {
  final String userEmail;

  const UseTokenPage({super.key, required this.userEmail});

  @override
  _UseTokenPageState createState() => _UseTokenPageState();
}

class _UseTokenPageState extends State<UseTokenPage> {
  int userTokens = 0;
  int userCredits = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await DatabaseHelper().getUser(widget.userEmail);
    if (user != null) {
      setState(() {
        userTokens = user['tokens'] ?? 0;
        userCredits = user['credits'] ?? 0;
      });
    }
  }

  Future<void> _useToken() async {
    final now = DateTime.now();

    if (now.hour < 12 || now.hour >= 23) {
      _showMessage('Token can only be used between 12 PM and 11 PM.');
      return;
    }

    if (userTokens > 0) {
      int updatedTokens = userTokens - 1;

      await DatabaseHelper().updateUserTokens(
        widget.userEmail,
        updatedTokens,
        userCredits, // credits unchanged
      );

      setState(() {
        userTokens = updatedTokens;
      });

      _showMessage('Token used successfully!');
    } else {
      _showMessage('No tokens available to use.');
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Use Token'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue[300]),
              const SizedBox(height: 30),
              Text(
                'Available Tokens: $userTokens',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _useToken,
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
                  'Use Token',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tokens can be used only between 12:00 PM and 11:00 PM.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              BuyTokenPage(userEmail: widget.userEmail),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back to Buy Token',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
