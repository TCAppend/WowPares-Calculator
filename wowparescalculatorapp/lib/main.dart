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

class _ReceiptsDashboardPageState extends State<ReceiptsDashboardPage> with SingleTickerProviderStateMixin {
  List<String> drawerItems = [];
  List<ReceiptData> receipts = [];
  late TabController _tabController;
  int _selectedIndex = 0; // Add this for bottom nav
  
  @override
  void initState() {
    super.initState();
    // Initialize tab controller first
    _tabController = TabController(length: 1, vsync: this);
    
    loadReceipts().then((loadedReceipts) {
      setState(() {
        receipts = loadedReceipts;
        drawerItems = List.generate(loadedReceipts.length, (i) {
          final date = loadedReceipts[i].createdAt;
          return 'Receipt ${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
        });
      });
    });
  }

  // Update _addNewReceipt to include date in name
  void _addNewReceipt() {
    setState(() {
      final now = DateTime.now();
      receipts.add(ReceiptData(isCompleted: false));  // Explicitly set initial value
      drawerItems.add('Receipt ${now.day}/${now.month} ${now.hour}:${now.minute.toString().padLeft(2, '0')}');
    });
  }

  // Separate function for saving receipt
  void _saveAndNavigate() {
    saveReceipts(receipts);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => receipt_page.ReceiptPage(
          title: drawerItems.last,
          receiptData: receipts.last,
        ),
      ),
    );
  }

  // Combined function that calls both
  void _addReceipt() {
    _addNewReceipt();
    _saveAndNavigate();
  }

  // Add this method in _ReceiptsDashboardPageState class after initState
List<ReceiptData> _getSortedReceipts() {
  // Create a copy of receipts to avoid modifying the original list during sort
  final sortedReceipts = List<ReceiptData>.from(receipts);
  // Sort by date, newest first
  sortedReceipts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return sortedReceipts;
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 182, 25, 25),
          title: const Text('Receipts', style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: 'All Receipts'),
            ],
          ),
        ),
        // Remove the drawer
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
              children: [
                Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Receipt'),
                  onPressed: _addReceipt,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 182, 25, 25),
                  foregroundColor: Colors.white,
                  ),
                ),
                ),
                const SizedBox(width: 16),
                Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text('Save to .csv'),
                  onPressed: () {
                    // Implement your save to CSV functionality here
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 185, 22),
                  foregroundColor: Colors.white,
                  ),
                ),
                ),
              ],
              ),
            ),
            Expanded(
              child: receipts.isEmpty
                ? const Center(child: Text('No receipts yet. Use the button above to add one!'))
                : ListView.separated(
                  itemCount: receipts.length,
                  separatorBuilder: (context, index) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                  final sortedReceipts = _getSortedReceipts();
                  final receipt = sortedReceipts[index];
                  final date = receipt.createdAt;
                  
                  return ListTile(
                    leading: Checkbox(
                    value: receipt.isCompleted,
                    activeColor: const Color.fromARGB(255, 182, 25, 25),
                    onChanged: (bool? value) {
                      setState(() {
                      receipt.isCompleted = value ?? false;
                      saveReceipts(receipts); // Make sure this is called
                      });
                    },
                    ),
                    title: Text(
                    'Receipt ${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                      decoration: receipt.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                    ),
                    subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'Total: ${receipt.getTotal()}',
                      style: TextStyle(
                        color: index == 0 ? Theme.of(context).primaryColor : null,
                      ),
                      ),
                      Text(
                      '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: index == 0 ? Colors.grey[600] : Colors.grey,
                      ),
                      ),
                    ],
                    ),
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => receipt_page.ReceiptPage(
                        title: drawerItems[index],
                        receiptData: receipts[index],
                      ),
                      ),
                    ).then((_) {
                      saveReceipts(receipts); // Save receipts
                      setState(() {}); // trigger rebuild
                    });
                    },
                    trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Delete Receipt',
                    onPressed: () {
                      setState(() {
                      receipts.removeAt(index);
                      drawerItems.removeAt(index);
                      });
                      saveReceipts(receipts);
                    },
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
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 182, 25, 25),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
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
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}




