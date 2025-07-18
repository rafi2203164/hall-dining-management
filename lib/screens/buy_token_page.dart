import 'package:flutter/material.dart';

class BuyTokenPage extends StatefulWidget {
  final String userEmail;

  const BuyTokenPage({super.key, required this.userEmail});

  @override
  _BuyTokenPageState createState() => _BuyTokenPageState();
}

class _BuyTokenPageState extends State<BuyTokenPage> {
  final List<String> halls = [
    'Ziaur Rahman Hall',
    'Hamid Hall',
    'Selim Hall',
    'Shohidul Islam Hall',
    'Tinshed Hall',
  ];

  String? selectedHall;
  int tokensToBuy = 1;
  int currentCredit = 100;
  int tokenPrice = 10;

  @override
  Widget build(BuildContext context) {
    int totalCost = tokensToBuy * tokenPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Token'),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              'Current Credit: $currentCredit',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedHall,
              items:
                  halls.map((hall) {
                    return DropdownMenuItem<String>(
                      value: hall,
                      child: Text(hall),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedHall = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Hall',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text('Tokens:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                DropdownButton<int>(
                  value: tokensToBuy,
                  items:
                      List.generate(10, (index) => index + 1)
                          .map(
                            (num) => DropdownMenuItem<int>(
                              value: num,
                              child: Text(num.toString()),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      tokensToBuy = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Total Cost: $totalCost credits',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                if (selectedHall == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a hall')),
                  );
                  return;
                }

                if (totalCost > currentCredit) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Not enough credits')),
                  );
                  return;
                }

                setState(() {
                  currentCredit -= totalCost;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Purchased $tokensToBuy token(s) for $selectedHall',
                    ),
                  ),
                );
              },
              child: const Text('Buy Tokens'),
            ),
          ],
        ),
      ),
    );
  }
}
