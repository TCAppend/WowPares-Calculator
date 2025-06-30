import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'receipt.dart';
import 'results_page.dart';

class ReceiptPage extends StatefulWidget {
  final String title;
  final ReceiptData receiptData;

  const ReceiptPage({super.key, required this.title, required this.receiptData});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late TextEditingController userMoneyController;

  @override
  void initState() {
    super.initState();
    userMoneyController = TextEditingController(text: widget.receiptData.userMoney.toString());
  }

  @override
  void dispose() {
    userMoneyController.dispose();
    super.dispose();
  }

  int getTotal() {
    final d = widget.receiptData;
    int dishesTotal = (60 * d.paresRegularAmount) +
        (50 * d.paresMamiAmount) +
        (75 * d.paresBagnetAmount) +
        (130 * d.paresOverloadAmount) +
        (20 * d.lugawAmount) +
        (50 * d.lugawSpecialAmount);

    int drinksTotal = (25 * d.cokeAmount) +
        (25 * d.spriteAmount) +
        (25 * d.mountainDewAmount) +
        (25 * d.royalAmount) +
        (25 * d.waterBottleSmallAmount) + 
        (35 * d.waterBottleLargeAmount);

    int extrasTotal = (15 * d.rice) + 
        (15 * d.egg) + 
        (15 * d.tokwa); 

    return dishesTotal + drinksTotal + extrasTotal;
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.receiptData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 182, 25, 25),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const Text("Dishes:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    CardGridWidget(
                      name: 'Pares Regular (60)',
                      counter: d.paresRegularAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.paresRegularAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Pares Mami (50)',
                      counter: d.paresMamiAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.paresMamiAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Pares Bagnet (75)',
                      counter: d.paresBagnetAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.paresBagnetAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Pares Overload (130)',
                      counter: d.paresOverloadAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.paresOverloadAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Lugaw (20)',
                      counter: d.lugawAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.lugawAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Lugaw Special (50)',
                      counter: d.lugawSpecialAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.lugawSpecialAmount = newCount;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Drinks:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    CardGridWidget(
                      name: 'Coke (25)',
                      counter: d.cokeAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.cokeAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Sprite (25)',
                      counter: d.spriteAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.spriteAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Mountain Dew (25)',
                      counter: d.mountainDewAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.mountainDewAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Royal (25)',
                      counter: d.royalAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.royalAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Water Bottle small(25)',
                      counter: d.waterBottleSmallAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.waterBottleSmallAmount = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Water Bottle large(35)',
                      counter: d.waterBottleLargeAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.waterBottleLargeAmount = newCount;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Extra:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    CardGridWidget(
                      name: 'Rice (15)',
                      counter: d.rice,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.rice = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Egg (15)',
                      counter: d.egg,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.egg = newCount;
                        });
                      },
                    ),
                    CardGridWidget(
                      name: 'Tokwa (15)',
                      counter: d.tokwa,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.tokwa = newCount;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text("Total value: ${getTotal()}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: userMoneyController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'User Money',
                        ),
                        onChanged: (value) {
                          setState(() {
                            d.userMoney = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultsPage(
                              ParesValue: 60,
                              ParesRegular_Amount: d.paresRegularAmount,
                              ParesMamiValue: 50,
                              ParesMami_Amount: d.paresMamiAmount,
                              ParesBagnetValue: 75,
                              ParesBagnet_Amount: d.paresBagnetAmount,
                              ParesOverloadValue: 130,
                              ParesOverload_Amount: d.paresOverloadAmount,
                              LugawValue: 20,
                              Lugaw_Amount: d.lugawAmount,
                              LugawspecialValue: 50, // Assuming same value as regular Lugaw
                              Lugawspecial_Amount: d.lugawSpecialAmount,
                              CokeValue: 25,
                              CokeAmount: d.cokeAmount,
                              SpriteValue: 25,
                              SpriteAmount: d.spriteAmount,
                              MountainDewValue: 25,
                              MountainDewAmount: d.mountainDewAmount,
                              RoyalValue: 25,
                              RoyalAmount: d.royalAmount,
                              WaterBottlesmallValue: 25,
                              WaterBottlesmallAmount: d.waterBottleSmallAmount,
                              WaterBottlelargeValue: 35,
                              WaterBottlelargeAmount: d.waterBottleLargeAmount,
                              RiceValue: 15,
                              Rice: d.rice,
                              eggValue: 15,
                              eggPrice: d.egg, // Assuming egg is a count, not a price
                              TokwaValue: 20, // Assuming Tokwa has a value of 20
                              TokwaPrice: d.tokwa, // Assuming tokwa is a count, not a price
                              // User Money
                              Money: d.userMoney, 
                            ),
                          ),
                        );
                      },
                      child: const Text("Results"),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Copy your CardGridWidget here so it's available in this file:
class CardGridWidget extends StatelessWidget {
  final String name;
  final int counter;
  final ValueChanged<int> onCounterChanged;

  const CardGridWidget({
    super.key,
    required this.name,
    required this.counter,
    required this.onCounterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  iconSize: isSmallScreen ? 18 : 24,
                  onPressed: () {
                    if (counter > 0) onCounterChanged(counter - 1);
                  },
                ),
                Text(
                  '$counter',
                  style: TextStyle(fontSize: isSmallScreen ? 14 : 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: isSmallScreen ? 18 : 24,
                  onPressed: () {
                    onCounterChanged(counter + 1);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}