import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
 // Dishes
  final int ParesValue;
  final int ParesRegular_Amount;

  final int ParesMamiValue;
  final int ParesMami_Amount;

  final int ParesBagnetValue;
  final int ParesBagnet_Amount;

  final int ParesOverloadValue;
  final int ParesOverload_Amount;

  final int LugawValue;
  final int Lugaw_Amount;

  // Drinks
  final int CokeValue;
  final int CokeAmount;

  final int SpriteValue;
  final int SpriteAmount;

  final int MountainDewValue;
  final int MountainDewAmount;

  final int RoyalValue;
  final int RoyalAmount;

  final int WaterBottlesmallValue;
  final int WaterBottlesmallAmount;

  //Extra
  final int RiceValue;
  final int Rice;

  // User money
  final int Money;


  const ResultsPage({super.key, 
     // Dishes
    required this.ParesValue,
    required this.ParesRegular_Amount,

    required this.ParesMamiValue,
    required this.ParesMami_Amount,

    required this.ParesBagnetValue,
    required this.ParesBagnet_Amount,

    required this.ParesOverloadValue,
    required this.ParesOverload_Amount,

    required this.LugawValue,
    required this.Lugaw_Amount,

    // Drinks
    required this.CokeValue,
    required this.CokeAmount,

    required this.SpriteValue,
    required this.SpriteAmount,

    required this.MountainDewValue,
    required this.MountainDewAmount,

    required this.RoyalValue,
    required this.RoyalAmount,

    required this.WaterBottlesmallValue,
    required this.WaterBottlesmallAmount,

    //Extra
    required this.RiceValue,
    required this.Rice,

    //user money
    required this.Money,
  });





   @override
Widget build(BuildContext context) {
  final int total = 
      (ParesValue * ParesRegular_Amount) +
      (ParesMamiValue * ParesMami_Amount) +
      (ParesBagnetValue * ParesBagnet_Amount) +
      (ParesOverloadValue * ParesOverload_Amount) +
      (LugawValue * Lugaw_Amount) +
      (CokeValue * CokeAmount) +
      (SpriteValue * SpriteAmount) +
      (MountainDewValue * MountainDewAmount) +
      (RoyalValue * RoyalAmount) +
      (WaterBottlesmallValue * WaterBottlesmallAmount) +
      (RiceValue * Rice);

  List<Widget> items = [];

  void addItem(String label, int value) {
    if (value > 0) {
      items.add(Text("$label: $value", style: TextStyle(fontSize: 18)));
    }
  }

  
  addItem("Regular Pares", ParesValue * ParesRegular_Amount);
  addItem("Mami Pares", ParesMamiValue * ParesMami_Amount);
  addItem("Bagnet Pares", ParesBagnetValue * ParesBagnet_Amount);
  addItem("Overload Pares", ParesOverloadValue * ParesOverload_Amount);
  addItem("Lugaw", LugawValue * Lugaw_Amount);

  addItem("Coke", CokeValue * CokeAmount);
  addItem("Sprite", SpriteValue * SpriteAmount);
  addItem("Mountain Dew", MountainDewValue * MountainDewAmount);
  addItem("Royal", RoyalValue * RoyalAmount);
  addItem("Water Bottle", WaterBottlesmallValue * WaterBottlesmallAmount);

  addItem("Rice", RiceValue * Rice);


  int Final = Money - total;
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 182, 25, 25),
      title: Text('WowPares Calculator', style: TextStyle(color: Colors.white)),
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (items.isNotEmpty)
              Text("Order Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...items,
            SizedBox(height: 20),
            Text("Total income: $total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Customer money: $Money", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Customer change: $Final", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      ElevatedButton(
                        onPressed: () {
                        Navigator.pop(context);
                        },
                         child: Text("Go Back"),
                         ),
                      ElevatedButton(
              onPressed: () {
                
              },
              child: Text("Save receipt"),
            ),
                ]
            ),
          ],
          
        ),
      ),
      
    ),
  );
}

}
