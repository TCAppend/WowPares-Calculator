import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final int ParesValue;
  final int ParesRegular_Amount;

  final int ParesMamiValue;
  final int ParesMami_Amount;

  final int RiceValue;
  final int Rice;


  ResultsPage({
    required this.ParesValue,
    required this.ParesRegular_Amount,

    required this.ParesMamiValue,
    required this.ParesMami_Amount,

    required this.RiceValue,
    required this.Rice,
  });



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 182, 25, 25),
        title: Text(
          'WowPares Calculator', style: TextStyle( color: Colors.white),
          ),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Regular pares amount: ${ParesValue * ParesRegular_Amount}", style: TextStyle(fontSize: 18)),
            Text("Mami Pares Amount: ${ParesMamiValue * ParesMami_Amount}", style: TextStyle(fontSize: 18)),
            Text("Rice Amount: ${RiceValue * Rice}", style: TextStyle(fontSize: 18)),
            Text("Total: ${(RiceValue * Rice) + (ParesMamiValue * ParesMami_Amount) + (ParesValue * ParesRegular_Amount)}"  , style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the first page
              },
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
