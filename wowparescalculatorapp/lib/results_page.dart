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

  final int WaterBottleValue;
  final int WaterBottleAmount;

  //Extra
  final int RiceValue;
  final int Rice;


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

    required this.WaterBottleValue,
    required this.WaterBottleAmount,

    //Extra
    required this.RiceValue,
    required this.Rice,
  });





   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 182, 25, 25),
        title: Text(
          'WowPares Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Dishes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Regular Pares: ${ParesValue * ParesRegular_Amount}", style: TextStyle(fontSize: 18)),
                    Text("Mami Pares: ${ParesMamiValue * ParesMami_Amount}", style: TextStyle(fontSize: 18)),
                    Text("Bagnet Pares: ${ParesBagnetValue * ParesBagnet_Amount}", style: TextStyle(fontSize: 18)),
                    Text("Overload Pares: ${ParesOverloadValue * ParesOverload_Amount}", style: TextStyle(fontSize: 18)),
                    Text("Lugaw: ${LugawValue * Lugaw_Amount}", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Column(
                  children: [
                    Text("Drinks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Coke: ${CokeValue * CokeAmount}", style: TextStyle(fontSize: 18)),
                    Text("Sprite: ${SpriteValue * SpriteAmount}", style: TextStyle(fontSize: 18)),
                    Text("Mountain Dew: ${MountainDewValue * MountainDewAmount}", style: TextStyle(fontSize: 18)),
                    Text("Royal: ${RoyalValue * RoyalAmount}", style: TextStyle(fontSize: 18)),
                    Text("Water Bottle: ${WaterBottleValue * WaterBottleAmount}", style: TextStyle(fontSize: 18)),
                  ],
                ),
                Column(
                  children: [
                    Text("Extras", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Rice: ${RiceValue * Rice}", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Total: ${(RiceValue * Rice) + (ParesMamiValue * ParesMami_Amount) + (ParesValue * ParesRegular_Amount) + (ParesBagnetValue * ParesBagnet_Amount) + (ParesOverloadValue * ParesOverload_Amount) + (LugawValue * Lugaw_Amount) + (CokeValue * CokeAmount) + (SpriteValue * SpriteAmount) + (MountainDewValue * MountainDewAmount) + (RoyalValue * RoyalAmount) + (WaterBottleValue * WaterBottleAmount)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
