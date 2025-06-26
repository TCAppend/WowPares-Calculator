import 'package:flutter/material.dart';
import 'receipt.dart';

class ReceiptPage extends StatefulWidget {
  final String title;
  final ReceiptData receiptData;

  const ReceiptPage({super.key, required this.title, required this.receiptData});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late ReceiptData data;

  @override
  void initState() {
    super.initState();
    data = widget.receiptData;
  }

  @override
  Widget build(BuildContext context) {
    // Copy your CardListView and related UI here,
    // but use `data` for the state instead of the main page's variables.
    // For example:
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 182, 25, 25),
      ),
    );
  }
}