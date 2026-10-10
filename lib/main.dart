import 'package:flutter/material.dart';
import 'dart:math';

import 'dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),

        useMaterial3: true,
      ),

      home: const DiceScreen(),
    );

  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}


class _DiceScreenState extends State<DiceScreen> {
  int dice1 = 1;
  int dice2 = 1;

  int total = 2;

  String imagePath = 'assets/sad.png';
  String resultText = 'Sad';



  void rollDice() {
    setState(() {
      dice1 = Random().nextInt(6) + 1;
      dice2 = Random().nextInt(6) + 1;

      total = dice1 + dice2;

      if (total >= 10) {
        imagePath = 'assets/happy.png';
        resultText = 'Happy : you win';
      } else {
        imagePath = 'assets/sad.png';
        resultText = 'Sad';
      }
    });
  }



  void resetGame() {
    setState(() {
      dice1 = 1;
      dice2 = 1;

      total = 2;

      imagePath = 'assets/sad.png';
      resultText = 'Sad';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Game'),
        centerTitle: true,
        leading: const Icon(Icons.casino),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Text(
              'Total: $total',
              style: Theme.of(context).textTheme.headlineMedium,
            ),


            Column(
              children: [
                Text(
                  resultText,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: resultText.startsWith('Happy')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

                const SizedBox(height: 10),

                Image.asset(
                  imagePath,
                  height: 150,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Dice(value: dice1),
                Dice(value: dice2),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: rollDice,
                    child: const Text('Roll'),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton(
                    onPressed: resetGame,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}