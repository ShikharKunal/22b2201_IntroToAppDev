import 'package:flutter/material.dart';
import 'home.dart';

class NextPage extends StatefulWidget {
  final List<String> budgetDescription;
  final List<int> budgetAmount;

  const NextPage({Key? key, required this.budgetDescription, required this.budgetAmount})
      : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int finalAmount() {
    return calculateTotalAmount(widget.budgetAmount);
  }

  // Function to handle the navigation back to HomePage with the updated data
  void _navigateBack() {
    // Update the data before navigating back
    final updatedData = {
      'budgetDescription': widget.budgetDescription,
      'budgetAmount': widget.budgetAmount,
    };

    Navigator.pop(context, updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUDGET TRACKER'),
        backgroundColor: Colors.deepPurple[300],
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              _navigateBack();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 9, 16, 5),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 8)
                    )
                  ]
              ),
              child: Row(
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${finalAmount()} Rs',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final String description = widget.budgetDescription[index];
                  final int amount = widget.budgetAmount[index];
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 9, 16, 5),
                          width: 280,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade600,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 8)
                                )
                              ]
                          ),
                          child: Row(
                            children: [
                              Text(
                                description,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Text(
                                amount.toString() + ' Rs',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.budgetDescription.removeAt(index);
                              widget.budgetAmount.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete_outline_sharp),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: widget.budgetAmount.length,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple[200],
    );
  }
}

int calculateTotalAmount(List<int> budgetAmount) {
  int sum = 0;
  for (int amount in budgetAmount) {
    sum += amount;
  }
  return sum;
}
