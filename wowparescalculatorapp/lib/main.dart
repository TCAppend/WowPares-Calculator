import 'package:flutter/material.dart';
import 'results_page.dart';
import 'package:flutter/services.dart';

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

  int WaterBottlesmallValue = 20;
  int WaterBottlesmallAmount = 0;

  //Extra:
  int RiceValue = 15;
  int Rice = 0;

  //User Money
 TextEditingController userMoneyController = TextEditingController();
int User_Money = 0;

int getTotal() {
  // Dishes
  int dishesTotal = (ParesValue * ParesRegular_Amount) +
                    (ParesMamiValue * ParesMami_Amount) +
                    (ParesBagnetValue * ParesBagnet_Amount) +
                    (ParesOverloadValue * ParesOverload_Amount) +
                    (LugawValue * Lugaw_Amount);

  // Drinks
  int drinksTotal = (CokeValue * CokeAmount) +
                    (SpriteValue * Spriteamount) +
                    (MountainDewValue * MountainDewAmount) +
                    (RoyalValue * RoyalAmount) +
                    (WaterBottlesmallValue * WaterBottlesmallAmount);

  // Extra
  int extrasTotal = (RiceValue * Rice);

  // Return the sum of everything
  return dishesTotal + drinksTotal + extrasTotal;
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
         child: ListView(
  padding: EdgeInsets.all(8),
  children: [
    Text("Dishes:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    GridView.count(
      shrinkWrap: true, // Important: Makes GridView fit inside ListView
      physics: NeverScrollableScrollPhysics(), // Prevents GridView from scrolling
      crossAxisCount: 2, // Number of columns
      childAspectRatio: 3 / 2, // Adjust to match card size
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [

        CardGridWidget(
          name: 'Pares Regular ($ParesValue)',
          counter: ParesRegular_Amount,
          onCounterChanged: (newCount) {
            setState(() {
              ParesRegular_Amount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Pares Mami ($ParesMamiValue)',
          counter: ParesMami_Amount,
          onCounterChanged: (newCount) {
            setState(() {
              ParesMami_Amount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Pares Bagnet ($ParesBagnetValue)',
          counter: ParesBagnet_Amount,
          onCounterChanged: (newCount) {
            setState(() {
              ParesBagnet_Amount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Pares Overload ($ParesOverloadValue)',
          counter: ParesOverload_Amount,
          onCounterChanged: (newCount) {
            setState(() {
              ParesOverload_Amount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Lugaw ($LugawValue)',
          counter: Lugaw_Amount,
          onCounterChanged: (newCount) {
            setState(() {
              Lugaw_Amount = newCount;
            });
          },
        ),
      ],
    ),

    SizedBox(height: 16),


    Text("Drinks:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        CardGridWidget(
          name: 'Coke (25)',
          counter: CokeAmount,
          onCounterChanged: (newCount) {
            setState(() {
              CokeAmount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Sprite (25)',
          counter: Spriteamount,
          onCounterChanged: (newCount) {
            setState(() {
              Spriteamount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Mountain Dew (25)',
          counter: MountainDewAmount,
          onCounterChanged: (newCount) {
            setState(() {
              MountainDewAmount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Royal (25)',
          counter: RoyalAmount,
          onCounterChanged: (newCount) {
            setState(() {
              RoyalAmount = newCount;
            });
          },
        ),
        CardGridWidget(
          name: 'Water Bottle small(20)',
          counter: WaterBottlesmallAmount,
          onCounterChanged: (newCount) {
            setState(() {
              WaterBottlesmallAmount = newCount;
            });
          },
        ),
      ],
    ),

    SizedBox(height: 16),
 
    Text("Extra:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        CardGridWidget(
          name: 'Rice ($RiceValue)',
          counter: Rice,
          onCounterChanged: (newCount) {
            setState(() {
              Rice = newCount;
            });
          },
        ),
      ],
    ),
  ],
),
        ),
Text("Total value: ${getTotal()}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
 Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Row(
      children: [
        
        // Text Field
       Expanded(
  flex: 6,
  child: Expanded(
  flex: 12,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: TextField(
      controller: userMoneyController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'User Money',
      ),
      onChanged: (value) {
        setState(() {
          User_Money = int.tryParse(value) ?? 0;
        });
      },
    ),
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
                    WaterBottlesmallValue: WaterBottlesmallValue,
                    WaterBottlesmallAmount: WaterBottlesmallAmount,

                    // Extra
                    RiceValue: RiceValue,
                    Rice: Rice,

                    // User Money 
                    Money: User_Money
                  ),
                ),
              );
            },
            child: Text("Results"),
          ),
        ),

        SizedBox(width: 8),

      ],
    ),
  ],
),

      ],
    );
  }
  
}


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

  
// Card format
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
                  icon: Icon(Icons.remove),
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
                  icon: Icon(Icons.add),
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



