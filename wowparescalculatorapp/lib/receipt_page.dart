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
        (80 * d.paresBagnetAmount) +
        (130 * d.paresOverloadAmount) +
        (20 * d.lugawAmount) +
        (50 * d.lugawSpecialAmount);

    int drinksTotal = (25 * d.cokeAmount) +
        (15 * d.spriteAmount) +
        (15 * d.mountainDewAmount) +
        (15 * d.royalAmount) +
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
                 
                CardGridWidget(
                  name: 'Pares Regular (60)',
                  counter: d.paresRegularAmount,
                  onCounterChanged: (newCount) {
                  setState(() {
                    d.paresRegularAmount = newCount;
                  });
                  },
                  imageAsset: 'assets/images/Regular_pares.png',
                ),
                
                CardGridWidget(
                  name: 'Pares Mami Special (50)',
                  counter: d.paresMamiAmount,
                  onCounterChanged: (newCount) {
                  setState(() {
                    d.paresMamiAmount = newCount;
                  });
                  },
                  imageAsset: 'assets/images/Pares_Mami.png',
                ),

                    CardGridWidget(
                      name: 'Pares Bagnet (80)',
                      counter: d.paresBagnetAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.paresBagnetAmount = newCount;
                        }); 
                      },
                      imageAsset: 'assets/images/Pares_bagnet.png',
                    ),
                    CardGridWidget(
                      name: 'Pares Overload (130)',
                      counter: d.paresOverloadAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.paresOverloadAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Pares_overload.png',
                    ),
                    CardGridWidget(
                      name: 'Lugaw (20)',
                      counter: d.lugawAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.lugawAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Plain_lugaw.png',
                    ),
                    CardGridWidget(
                      name: 'Lugaw Special (50)',
                      counter: d.lugawSpecialAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.lugawSpecialAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Special_lugaw.png',
                    ),
                    
                const SizedBox(height: 16),
                const Text("Drinks:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    
                    CardGridWidget(
                      name: 'Coke (15)',
                      counter: d.cokeAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.cokeAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Coke_regular.png',
                    ),
                    CardGridWidget(
                      name: 'Sprite (15)',
                      counter: d.spriteAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.spriteAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Sprite_regular.png',
                    ),
                    CardGridWidget(
                      name: 'Mountain Dew (15)',
                      counter: d.mountainDewAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.mountainDewAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/mountain_dew_regular.png',
                    ),
                    CardGridWidget(
                      name: 'Royal (15)',
                      counter: d.royalAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.royalAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Royal_regular.png',
                    ),
                    CardGridWidget(
                      name: 'Water Bottle small(25)',
                      counter: d.waterBottleSmallAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.waterBottleSmallAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Water_small.png',
                    ),
                    CardGridWidget(
                      name: 'Water Bottle large(35)',
                      counter: d.waterBottleLargeAmount,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.waterBottleLargeAmount = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Water_large.png',
                    ),

                const SizedBox(height: 16),
                const Text("Extra:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              
                    CardGridWidget(
                      name: 'Rice (15)',
                      counter: d.rice,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.rice = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Plain_Rice.png',
                    ),
                    CardGridWidget(
                      name: 'Boiled Egg (15)',
                      counter: d.egg,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.egg = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Boild_egg.png',
                    ),
                    CardGridWidget(
                      name: 'Tokwa (15)',
                      counter: d.tokwa,
                      onCounterChanged: (newCount) {
                        setState(() {
                          d.tokwa = newCount;
                        });
                      },
                      imageAsset: 'assets/images/Tokwa.png',
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
                              ParesBagnetValue: 80,
                              ParesBagnet_Amount: d.paresBagnetAmount,
                              ParesOverloadValue: 130,
                              ParesOverload_Amount: d.paresOverloadAmount,
                              LugawValue: 20,
                              Lugaw_Amount: d.lugawAmount,
                              LugawspecialValue: 50, 
                              Lugawspecial_Amount: d.lugawSpecialAmount,
                              CokeValue: 15,
                              CokeAmount: d.cokeAmount,
                              SpriteValue: 15,
                              SpriteAmount: d.spriteAmount,
                              MountainDewValue: 15,
                              MountainDewAmount: d.mountainDewAmount,
                              RoyalValue: 15,
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

class CardGridWidget extends StatelessWidget {
  final String name;
  final int counter;
  final ValueChanged<int> onCounterChanged;
  final String? imageAsset;

  const CardGridWidget({
    super.key,
    required this.name,
    required this.counter,
    required this.onCounterChanged,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 16,
          vertical: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show image if provided
            if (imageAsset != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  imageAsset!,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

            Text(
              name,
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),

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

