import 'package:flutter/material.dart';
import 'results_page.dart';

void main() {
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
      home: const MyHomePage(title: 'WowPares Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _InputData();
}

//Core Components
class _InputData extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 182, 25, 25),
        title: Text(
          widget.title, style: TextStyle( color: Colors.white),
          ),
      ), 
      body: Center(
        child: CardListView(),         
      ), 
    );
  }
}

class CardListView extends StatefulWidget {
  const CardListView({super.key});

  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  // List<int> counters = List.generate(3, (index) => 0); old
  //List<String> Food_Names = ['Regular Pares','Mami Pares','Rice',];

  //Dishes:
  int ParesValue = 50;
  int ParesRegular_Amount = 0;

  int ParesMamiValue = 50;
  int ParesMami_Amount = 0;

  int ParesBagnetValue = 75;
  int ParesBagnet_Amount = 0;

  int ParesOverloadValue = 120;
  int ParesOverload_Amount = 0;

  int LugawValue = 20;
  int Lugaw_Amount = 0;

  //Drinks:
  int CokeValue = 25;
  int CokeAmount = 0;

  int SpriteValue = 25;
  int Spriteamount = 0;

  int MountainDewValue = 25;
  int MountainDewAmount = 0;

  int RoyalValue = 25;
  int RoyalAmount = 0;

  int WaterBottleValue = 25;
  int WaterBottleAmount = 0;

  //Extra:
  int RiceValue = 15;
  int Rice = 0;

  //User Money
  TextEditingController User_Money = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              Text("Dishes: ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              CardGridWidget(
                name: 'Pares Regular',
                counter: ParesRegular_Amount,
                onCounterChanged: (newCount) {
                  setState(() {
                    ParesRegular_Amount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Pares Mami',
                counter: ParesMami_Amount,
                onCounterChanged: (newCount) {
                  setState(() {
                    ParesMami_Amount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Pares Bagnet',
                counter: ParesBagnet_Amount,
                onCounterChanged: (newCount) {
                  setState(() {
                    ParesBagnet_Amount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Pares Overload',
                counter: ParesOverload_Amount,
                onCounterChanged: (newCount) {
                  setState(() {
                    ParesOverload_Amount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Lugaw',
                counter: Lugaw_Amount,
                onCounterChanged: (newCount) {
                  setState(() {
                    Lugaw_Amount = newCount;
                  });
                },
              ),

              Text("Drinks: ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              CardGridWidget(
                name: 'Coke',
                counter: CokeAmount,
                onCounterChanged: (newCount) {
                  setState(() {
                    CokeAmount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Sprite',
                counter: Spriteamount,
                onCounterChanged: (newCount) {
                  setState(() {
                    SpriteValue = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Mountain Dew',
                counter: MountainDewAmount,
                onCounterChanged: (newCount) {
                  setState(() {
                    MountainDewAmount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Royal',
                counter: RoyalAmount,
                onCounterChanged: (newCount) {
                  setState(() {
                    RoyalAmount = newCount;
                  });
                },
              ),
              CardGridWidget(
                name: 'Water Bottle',
                counter: WaterBottleAmount,
                onCounterChanged: (newCount) {
                  setState(() {
                    WaterBottleAmount = newCount;
                  });
                },
              ),

              Text("Extra: ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              CardGridWidget(
                name: 'Rice',
                counter: Rice,
                onCounterChanged: (newCount) {
                  setState(() {
                    Rice = newCount;
                  });
                },
              ),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(
                  // Dishes
                  ParesValue: ParesValue,
                  ParesRegular_Amount: ParesRegular_Amount,
                  ParesMamiValue: ParesMamiValue,
                  ParesMami_Amount: ParesMami_Amount,
                  ParesBagnetValue: ParesBagnetValue,
                  ParesBagnet_Amount: ParesBagnet_Amount,
                  ParesOverloadValue: ParesOverloadValue,
                  ParesOverload_Amount: ParesOverload_Amount,
                  LugawValue: LugawValue,
                  Lugaw_Amount: Lugaw_Amount,

                  // Drinks
                  CokeValue: CokeValue,
                  CokeAmount: CokeAmount,
                  SpriteValue: SpriteValue,
                  SpriteAmount: Spriteamount,
                  MountainDewValue: MountainDewValue,
                  MountainDewAmount: MountainDewAmount,
                  RoyalValue: RoyalValue,
                  RoyalAmount: RoyalAmount,
                  WaterBottleValue: WaterBottleValue,
                  WaterBottleAmount: WaterBottleAmount,

                  // Extra
                  RiceValue: RiceValue,
                  Rice: Rice,
                ),
              ),
            );
          },
          child: Text("View Results"),
        ),
      ],
    );
  }
  
}


//Card Format
class CardGridWidget extends StatelessWidget {
  final String name;
  final int counter;
  final ValueChanged<int> onCounterChanged;

  const CardGridWidget({super.key, required this.name, required this.counter, required this.onCounterChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, )),
            SizedBox(height: 10),
            Image.network('https://via.placeholder.com/100', width: 100, height: 100),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (counter > 0) onCounterChanged(counter - 1);
                  },
                ),
                Text('$counter', style: TextStyle(fontSize: 18)),
                IconButton(
                  icon: Icon(Icons.add),
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


