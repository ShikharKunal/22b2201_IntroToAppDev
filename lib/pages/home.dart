import 'package:flutter/material.dart';
import 'next_page.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key});
  @override
  State<HomePage> createState() => _HomePageState();
}

final newDescriptionController = TextEditingController();
final newAmountController = TextEditingController();

class _HomePageState extends State<HomePage> {
  final List<String> budgetDescription = [];
  final List<int> budgetAmount = [];

  int finalAmount() {
    return calculateTotalAmount(budgetAmount);
  }

  // Function to handle the navigation to the NextPage and receive the result back
  _navigateToNextPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(
          budgetDescription: budgetDescription,
          budgetAmount: budgetAmount,
        ),
      ),
    );

    // Update the state with the result returned from NextPage
    if (result == null || result != null) {
      setState(() {
        budgetDescription;
        budgetAmount;
        budgetDescription.addAll(result['budgetDescription']);
        budgetAmount.addAll(result['budgetAmount']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUDGET TRACKER'),
        backgroundColor: Colors.deepPurple[300],
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 200,
                color: Colors.black87,
              ),
            ],
          ),
          const Text(
            'Welcome Back!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 9, 16, 5),
            width: 300,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 7)
                )
              ],
            ),
            child: Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Spacer(),
                Text(
                  '${finalAmount()} Rs',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _navigateToNextPage();
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 100),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add transactions:'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: newDescriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                      TextField(
                        controller: newAmountController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Amount',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          budgetDescription.add(newDescriptionController.text);
                          budgetAmount.add(int.parse(newAmountController.text));
                        });
                        newDescriptionController.clear();
                        newAmountController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                    MaterialButton(
                      onPressed: () {
                        newDescriptionController.clear();
                        newAmountController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    )
                  ],
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
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
