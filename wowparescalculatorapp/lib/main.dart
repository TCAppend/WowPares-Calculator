import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowparescalculatorapp/receipt_page.dart' as receipt_page;
import 'package:wowparescalculatorapp/receipt.dart';
import 'package:wowparescalculatorapp/bottombar.dart' as bottom_bar;

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
      home: (const WelcomePage()),
      //home: const WelcomePage(),
      debugShowCheckedModeBanner: false,  
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
            Navigator.pushReplacement(  // Change this line from push to pushReplacement
              context,
              MaterialPageRoute(
                builder: (context) => const ReceiptsDashboardPage(),
                
              ),
            );
          },
        ),
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
  List<String> drawerItems = [];
  List<ReceiptData> receipts = [];

  @override
  void initState() {
    super.initState();
    loadReceipts().then((loadedReceipts) {
      setState(() {
        receipts = loadedReceipts;
        drawerItems = List.generate(
            loadedReceipts.length, (i) => 'New Receipt ${i + 1}');
      });
    });
  }

  // Separate function for adding receipt
  void _addNewReceipt() {
    setState(() {
      receipts.add(ReceiptData());
      drawerItems.add('New Receipt ${drawerItems.length + 1}');
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

  Widget Navigatetodashboard() {
    return ListTile(
      title: const Text('Dashboard'),
      onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
            );
          },
    );
    
  }

Widget NavigateReceipt() {
    return ListTile( 
      title: const Text('Receipts'),
      onTap: () {
        Navigator.pop(context); // This will just close the drawer
      },
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 25, 25),
        title: const Text('Receipts', style: TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 182, 25, 25)),
              child: Text(
                'Wow Pares Calculator',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Navigatetodashboard(),
            NavigateReceipt(),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Expanded(
            child: receipts.isEmpty
                ? const Center(child: Text('No receipts yet. Use the button above to add one!'))
                : ListView.builder(
                    itemCount: receipts.length,
                    itemBuilder: (context, index) {
                      final receipt = receipts[index];
                      return ListTile(
                        title: Text(drawerItems[index]),
                        subtitle: Text('Total: ${receipt.getTotal()}'),
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
        setState(() {}); // Add this line to trigger rebuild
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
    );
  }
}


