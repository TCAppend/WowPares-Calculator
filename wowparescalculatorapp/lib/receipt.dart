import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ReceiptData {
  // Dishes
  int paresRegularAmount;
  int paresMamiAmount;
  int paresBagnetAmount;
  int paresOverloadAmount;
  int lugawAmount;
  int lugawSpecialAmount;

  // Drinks
  int cokeAmount;
  int spriteAmount;
  int mountainDewAmount;
  int royalAmount;
  int waterBottleSmallAmount;
  int waterBottleLargeAmount;

  // Extra
  int rice;
  int egg;
  int tokwa;

  // User Money
  int userMoney;

  ReceiptData({
    this.paresRegularAmount = 0,
    this.paresMamiAmount = 0,
    this.paresBagnetAmount = 0,
    this.paresOverloadAmount = 0,
    this.lugawAmount = 0,
    this.cokeAmount = 0,
    this.spriteAmount = 0,
    this.mountainDewAmount = 0,
    this.royalAmount = 0,
    this.waterBottleSmallAmount = 0,
    this.rice = 0,
    this.lugawSpecialAmount = 0,
    this.waterBottleLargeAmount = 0,  
    this.egg = 0,
    this.tokwa = 0,
    this.userMoney = 0,
  });

  int getTotal() {
    return (60 * paresRegularAmount) +
        (50 * paresMamiAmount) +
        (80 * paresBagnetAmount) +
        (130 * paresOverloadAmount) +
        (20 * lugawAmount) +
        (50 * lugawSpecialAmount) +
        (15 * cokeAmount) +
        (15 * spriteAmount) +
        (15 * mountainDewAmount) +
        (15 * royalAmount) +
        (25 * waterBottleSmallAmount) +
        (35 * waterBottleLargeAmount) +
        (15 * rice) +
        (15 * egg) +
        (15 * tokwa);
  }

  ReceiptData copyWith({
    int? paresRegularAmount,
    int? paresMamiAmount,
    int? paresBagnetAmount,
    int? paresOverloadAmount,
    int? lugawAmount,
    int? cokeAmount,
    int? spriteAmount,
    int? mountainDewAmount,
    int? royalAmount,
    int? waterBottleSmallAmount,
    int? rice,
    int? userMoney,
    int? lugawSpecialAmount,
    int? waterBottleLargeAmount,  
    int? egg,
    int? tokwa,
  }) {
    return ReceiptData(
      paresRegularAmount: paresRegularAmount ?? this.paresRegularAmount,
      paresMamiAmount: paresMamiAmount ?? this.paresMamiAmount,
      paresBagnetAmount: paresBagnetAmount ?? this.paresBagnetAmount,
      paresOverloadAmount: paresOverloadAmount ?? this.paresOverloadAmount,
      lugawAmount: lugawAmount ?? this.lugawAmount,
      cokeAmount: cokeAmount ?? this.cokeAmount,
      spriteAmount: spriteAmount ?? this.spriteAmount,
      mountainDewAmount: mountainDewAmount ?? this.mountainDewAmount,
      royalAmount: royalAmount ?? this.royalAmount,
      waterBottleSmallAmount: waterBottleSmallAmount ?? this.waterBottleSmallAmount,
      rice: rice ?? this.rice,
      lugawSpecialAmount: lugawSpecialAmount ?? this.lugawSpecialAmount,
      waterBottleLargeAmount: waterBottleLargeAmount ?? this.waterBottleLargeAmount,
      egg: egg ?? this.egg,
      tokwa: tokwa ?? this.tokwa,
      userMoney: userMoney ?? this.userMoney,
    );
  }

  Map<String, dynamic> toJson() => {
    'paresRegularAmount': paresRegularAmount,
    'paresMamiAmount': paresMamiAmount,
    'paresBagnetAmount': paresBagnetAmount,
    'paresOverloadAmount': paresOverloadAmount,
    'lugawAmount': lugawAmount,
    'lugawSpecialAmount': lugawSpecialAmount,
    'cokeAmount': cokeAmount,
    'spriteAmount': spriteAmount,
    'mountainDewAmount': mountainDewAmount,
    'royalAmount': royalAmount,
    'waterBottleSmallAmount': waterBottleSmallAmount,
    'waterBottleLargeAmount': waterBottleLargeAmount,
    'rice': rice,
    'egg': egg,
    'tokwa': tokwa,
    'userMoney': userMoney,
  };

  factory ReceiptData.fromJson(Map<String, dynamic> json) => ReceiptData(
    paresRegularAmount: json['paresRegularAmount'] ?? 0,
    paresMamiAmount: json['paresMamiAmount'] ?? 0,
    paresBagnetAmount: json['paresBagnetAmount'] ?? 0,
    paresOverloadAmount: json['paresOverloadAmount'] ?? 0,
    lugawAmount: json['lugawAmount'] ?? 0,
    lugawSpecialAmount: json['lugawSpecialAmount'] ?? 0,
    cokeAmount: json['cokeAmount'] ?? 0,
    spriteAmount: json['spriteAmount'] ?? 0,
    mountainDewAmount: json['mountainDewAmount'] ?? 0,
    royalAmount: json['royalAmount'] ?? 0,
    waterBottleSmallAmount: json['waterBottleSmallAmount'] ?? 0,
    waterBottleLargeAmount: json['waterBottleLargeAmount'] ?? 0,
    rice: json['rice'] ?? 0,
    egg: json['egg'] ?? 0,
    tokwa: json['tokwa'] ?? 0,
    userMoney: json['userMoney'] ?? 0,
  );
}

// Save receipts
Future<void> saveReceipts(List<ReceiptData> receipts) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = receipts.map((r) => r.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    final bool success = await prefs.setString('receipts', jsonString);
    
    if (!success) {
      debugPrint('Warning: Failed to save receipts');
    }
  } catch (e) {
    debugPrint('Error saving receipts: $e');
    rethrow; // Re-throw the error so the UI can handle it
  }
}

// Load receipts
Future<List<ReceiptData>> loadReceipts() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('receipts');
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ReceiptData.fromJson(json)).toList();
  } catch (e) {
    debugPrint('Error loading receipts: $e');
    return [];
  }
}

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  List<ReceiptData> receipts = [];

  @override
  void initState() {
    super.initState();
    loadReceipts().then((loadedReceipts) {
      setState(() {
        receipts = loadedReceipts;
      });
    });
  }

  void _addReceipt() {
    setState(() {
      receipts.add(ReceiptData());
    });
    saveReceipts(receipts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipts'),
      ),
      body: ListView.builder(
        itemCount: receipts.length,
        itemBuilder: (context, index) {
          final receipt = receipts[index];
          return ListTile(
            title: Text('Receipt ${index + 1}'),
            subtitle: Text('Total: ${receipt.getTotal()}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  receipts[index].paresRegularAmount++;
                });
                saveReceipts(receipts);
              },
            ),
          );
        },
      ),
    );
  }
}