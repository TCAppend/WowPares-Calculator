import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowparescalculatorapp/receipt_page.dart' as receipt_page;
import 'package:wowparescalculatorapp/receipt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance(); // Store the instance
  if (!prefs.containsKey('receipts')) { // Initialize if empty
    await prefs.setString('receipts', '[]');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 182, 25, 25)),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = 1; // Start with Dashboard selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 25, 25),
        title: const Text('WowPares Calculator', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.receipt_long),
          label: const Text('Go to Receipts'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ReceiptsDashboardPage(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Receipts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 182, 25, 25),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) { // Receipts
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ReceiptsDashboardPage(),
              ),
            );
          }
        },
      ),
    );
  }
}

//dashboard page 
class ReceiptsDashboardPage extends StatefulWidget {
  const ReceiptsDashboardPage({super.key});

  @override
  State<ReceiptsDashboardPage> createState() => _ReceiptsDashboardPageState();
}

class _ReceiptsDashboardPageState extends State<ReceiptsDashboardPage> {
  List<ReceiptData> receipts = [];
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    loadReceipts().then((loadedReceipts) {
      if (mounted) {
        setState(() {
          receipts = loadedReceipts;
          // Set initial selected date to today if receipts exist
          if (receipts.isNotEmpty) {
            final today = DateTime.now();
            selectedDate = _formatDate(today);
          }
        });
      }
    });
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Map<String, List<ReceiptData>> _groupReceiptsByDate() {
    Map<String, List<ReceiptData>> grouped = {};
    for (var receipt in receipts) {
      String dateKey = _formatDate(receipt.createdAt);
      grouped.putIfAbsent(dateKey, () => []).add(receipt);
    }
    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key))
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedReceipts = _groupReceiptsByDate();
    final dates = groupedReceipts.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 25, 25),
        title: const Text('Receipts', style: TextStyle(color: Colors.white)),
        actions: [
          if (dates.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dates.contains(selectedDate) ? selectedDate : null,
                    dropdownColor: const Color.fromARGB(255, 182, 25, 25),
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    items: dates.map((date) => DropdownMenuItem(
                      value: date,
                      child: Text(date),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                    hint: const Text(
                      'Select Date',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Add Receipt Button Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add Receipt', style: TextStyle(color: Colors.white),),
                    onPressed: _addNewReceipt,
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: const Color.fromARGB(255, 182, 25, 25),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Receipts List
          Expanded(
            child: receipts.isEmpty
                ? const Center(
                    child: Text(
                      'No receipts yet.\nTap the button above to add one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : selectedDate == null
                    ? const Center(child: Text('Select a date', style: TextStyle(fontSize: 20)),)
                    : ListView.separated(
                        itemCount: groupedReceipts[selectedDate]?.length ?? 0,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final receipt = groupedReceipts[selectedDate]![index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: receipt.isCompleted,
                                activeColor: const Color.fromARGB(255, 182, 25, 25),
                                onChanged: (bool? value) {
                                  setState(() {
                                    receipt.isCompleted = value ?? false;
                                    saveReceipts(receipts);
                                  });
                                },
                              ),
                              title: Text(
                                'Receipt ${receipt.createdAt.hour}:${receipt.createdAt.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  decoration: receipt.isCompleted ? TextDecoration.lineThrough : null,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                'Total: ₱${receipt.getTotal()}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _navigateToReceipt(receipt),
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteReceipt(receipt),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              onTap: () => _navigateToReceipt(receipt),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Receipts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 182, 25, 25),
        onTap: (index) {
          if (index == 1) { // Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
            );
          }
          // index 0 is current page (Receipts), so no navigation needed
        },
      ),
    );
  }

  void _addNewReceipt() {
    setState(() {
      final newReceipt = ReceiptData(isCompleted: false);
      receipts.add(newReceipt);
      
      // Navigate to the receipt page immediately
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => receipt_page.ReceiptPage(
            title: 'Receipt ${newReceipt.createdAt.day}/${newReceipt.createdAt.month} ${newReceipt.createdAt.hour}:${newReceipt.createdAt.minute}',
            receiptData: newReceipt,
          ),
        ),
      ).then((_) {
        setState(() {});
        saveReceipts(receipts);
      });
    });
  }

  void _navigateToReceipt(ReceiptData receipt) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => receipt_page.ReceiptPage(
          title: 'Receipt ${receipt.createdAt.day}/${receipt.createdAt.month} ${receipt.createdAt.hour}:${receipt.createdAt.minute}',
          receiptData: receipt,
        ),
      ),
    ).then((_) {
      setState(() {});
      saveReceipts(receipts);
    });
  }

  void _deleteReceipt(ReceiptData receipt) {
    setState(() {
      receipts.remove(receipt);
      
      // Update selectedDate if we just deleted the last receipt for that date
      final groupedReceipts = _groupReceiptsByDate();
      if (!groupedReceipts.containsKey(selectedDate)) {
        selectedDate = groupedReceipts.isEmpty ? null : groupedReceipts.keys.first;
      }
      
      saveReceipts(receipts);
    });
  }
}




