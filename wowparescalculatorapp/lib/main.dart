import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowparescalculatorapp/receipt_page.dart' as receipt_page;
import 'package:wowparescalculatorapp/receipt.dart';
import 'package:wowparescalculatorapp/bottombar.dart' as bottom_bar;
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance(); // Store the instance
  if (!prefs.containsKey('receipts')) { // Initialize if empty
    await prefs.setString('receipts', '[]');
  }
  
  runApp(const MyApp());

}

// Load receipts from SharedPreferences
Future<Map<String, Map<String, dynamic>>> calculateDailyStats() async {
  final receipts = await loadReceipts();

  Map<String, Map<String, dynamic>> dailyStats = {};

  for (var r in receipts) {
    String dateKey =
        "${r.createdAt.day.toString().padLeft(2, '0')}/${r.createdAt.month.toString().padLeft(2, '0')}/${r.createdAt.year}";

    if (!dailyStats.containsKey(dateKey)) {
      dailyStats[dateKey] = {"orders": 0, "revenue": 0.0};
    }

    dailyStats[dateKey]!["orders"] =
        (dailyStats[dateKey]!["orders"] as int) + 1;
    dailyStats[dateKey]!["revenue"] =
        (dailyStats[dateKey]!["revenue"] as double) + r.getTotal();
  }

  return dailyStats;
}
Future<Map<String, dynamic>> calculateStats() async {
  final receipts = await loadReceipts();
  final now = DateTime.now();
  final todayKey =
      "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

  int totalOrders = receipts.length;
  double totalRevenue = receipts.fold(0.0, (sum, r) => sum + r.getTotal());

  int dailyOrders = 0;
  double dailyRevenue = 0.0;

  for (var r in receipts) {
    String dateKey =
        "${r.createdAt.day.toString().padLeft(2, '0')}/${r.createdAt.month.toString().padLeft(2, '0')}/${r.createdAt.year}";

    if (dateKey == todayKey) {
      dailyOrders += 1;
      dailyRevenue += r.getTotal();
    }
  }

  return {
    "totalOrders": totalOrders,
    "totalRevenue": totalRevenue,
    "dailyOrders": dailyOrders,
    "dailyRevenue": dailyRevenue,
  };
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
      body:  Column(
        children: [
          Totalordersandrevenue(),
          Dailysummary(),
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
                        separatorBuilder: (context, index) => const Divider(height: 5),
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
  'Receipt ${DateFormat('h:mm a').format(receipt.createdAt)}',
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

extension on DateTime {
  get hourOfPeriod =>   hour % 12;
}


class Totalordersandrevenue extends StatefulWidget {
  const Totalordersandrevenue({super.key});

  @override
  _TotalordersandrevenueState createState() => _TotalordersandrevenueState();
}

class _TotalordersandrevenueState extends State<Totalordersandrevenue> {
  int totalOrders = 0;
  double totalRevenue = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await calculateStats();
    if (mounted) {
      setState(() {
        totalOrders = stats["totalOrders"];
        totalRevenue = stats["totalRevenue"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lime.withOpacity(0.6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          leading: const Icon(Icons.shopping_cart, color: Colors.black87),
          title: Text(
            "Total / Overall Orders: $totalOrders",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          subtitle: Text(
            "Total / Overall Revenue: ₱${totalRevenue.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}


class Dailysummary extends StatefulWidget {
  const Dailysummary({super.key});

  @override
  _DailysummaryState createState() => _DailysummaryState();
}

class _DailysummaryState extends State<Dailysummary> {
  Map<String, Map<String, dynamic>> dailyStats = {};

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await calculateDailyStats();
    if (mounted) {
      setState(() {
        dailyStats = stats;
      });
    }
  }

  String _getLabel(String dateKey) {
    final today = DateTime.now();
    final parts = dateKey.split("/");
    final date = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );

    final diff = date.difference(today).inDays;
    if (diff == 0) return "Today";
    if (diff == -1) return "Yesterday";
    if (diff == 1) return "Tomorrow";
    return dateKey;
  }

  @override
  Widget build(BuildContext context) {
    final sortedKeys = dailyStats.keys.toList()
      ..sort((a, b) {
        final partsA = a.split("/");
        final partsB = b.split("/");
        final dateA = DateTime(int.parse(partsA[2]), int.parse(partsA[1]), int.parse(partsA[0]));
        final dateB = DateTime(int.parse(partsB[2]), int.parse(partsB[1]), int.parse(partsB[0]));
        return dateB.compareTo(dateA); // newest first
      });

    return Card(
      color: Colors.red.withOpacity(0.6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: Icon(Icons.assessment_outlined, color: Colors.black87),
              title: Text(
                "Daily Sales Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 8),

            dailyStats.isEmpty
                ? const Center(child: Text("No sales data yet."))
                : SizedBox(
                    height: 300, // 👈 limit height so it doesn't overflow
                    child: ListView.separated(
                      itemCount: sortedKeys.length,
                      separatorBuilder: (_, __) => const Divider(height: 5),
                      itemBuilder: (context, index) {
                        final key = sortedKeys[index];
                        final stats = dailyStats[key]!;
                        return ListTile(
                          leading: const Icon(Icons.calendar_today, color: Colors.black87),
                          title: Text(
                            _getLabel(key),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "Orders: ${stats['orders']} | Revenue: ₱${(stats['revenue'] as double).toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

