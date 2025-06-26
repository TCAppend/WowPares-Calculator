import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
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
  final int RiceValue;
  final int Rice;
  final int Money;

  const ResultsPage({
    super.key,
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
    required this.RiceValue,
    required this.Rice,
    required this.Money,
  });

  @override
  Widget build(BuildContext context) {
    int total = (ParesValue * ParesRegular_Amount) +
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: const Color.fromARGB(255, 182, 25, 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (ParesRegular_Amount > 0)
              Text('Pares Regular: $ParesRegular_Amount x $ParesValue'),
            if (ParesMami_Amount > 0)
              Text('Pares Mami: $ParesMami_Amount x $ParesMamiValue'),
            if (ParesBagnet_Amount > 0)
              Text('Pares Bagnet: $ParesBagnet_Amount x $ParesBagnetValue'),
            if (ParesOverload_Amount > 0)
              Text('Pares Overload: $ParesOverload_Amount x $ParesOverloadValue'),
            if (Lugaw_Amount > 0)
              Text('Lugaw: $Lugaw_Amount x $LugawValue'),
            if (CokeAmount > 0)
              Text('Coke: $CokeAmount x $CokeValue'),
            if (SpriteAmount > 0)
              Text('Sprite: $SpriteAmount x $SpriteValue'),
            if (MountainDewAmount > 0)
              Text('Mountain Dew: $MountainDewAmount x $MountainDewValue'),
            if (RoyalAmount > 0)
              Text('Royal: $RoyalAmount x $RoyalValue'),
            if (WaterBottlesmallAmount > 0)
              Text('Water Bottle Small: $WaterBottlesmallAmount x $WaterBottlesmallValue'),
            if (Rice > 0)
              Text('Rice: $Rice x $RiceValue'),
            const SizedBox(height: 16),
            Text('Total: $total', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('User Money: $Money'),
            Text('Change: ${Money - total}'),
          ],
        ),
      ),
    );
  }
}
