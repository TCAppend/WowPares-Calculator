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
  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  // List<int> counters = List.generate(3, (index) => 0); old
  //List<String> Food_Names = ['Regular Pares','Mami Pares','Rice',];
  int ParesValue = 50;
  int ParesRegular_Amount = 0;

  int ParesMamiValue = 50;
  int ParesMami_Amount = 0;

  int RiceValue = 15;
  int Rice = 0;

   TextEditingController User_Money = TextEditingController();

  

 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
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
                name: 'pares Mami',
                counter: ParesMami_Amount,
                onCounterChanged: (newCount) {
                  setState(() {
                    ParesMami_Amount = newCount;
                  });
                },
              ),
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
          ParesValue: ParesValue,
          ParesRegular_Amount: ParesRegular_Amount,

          ParesMamiValue: ParesMamiValue,
          ParesMami_Amount: ParesMami_Amount,
          
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

  CardGridWidget({required this.name, required this.counter, required this.onCounterChanged});

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
            Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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


