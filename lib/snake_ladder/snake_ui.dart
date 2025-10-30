import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const SnakeAndLadderUI());
}

class SnakeAndLadderUI extends StatelessWidget {
  const SnakeAndLadderUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindful Snake & Ladder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SnakeLadderBoard(),
    );
  }
}

class SnakeLadderBoard extends StatefulWidget {
  const SnakeLadderBoard({super.key});

  @override
  State<SnakeLadderBoard> createState() => _SnakeLadderBoardState();
}

class _SnakeLadderBoardState extends State<SnakeLadderBoard> {
  int playerPosition = 0;
  int diceValue = 0;

  // Board labels (10 squares)
  final List<String> boardTexts = [
    'Back to square one!',
    'Gratitude',
    'Peace',
    'Hope',
    'Self Belief',
    'Power',
    'Self Love',
    'Kindness',
    'Strength',
    'The Good Life!'
  ];

  // Ladders and Snakes mapping (start : end)
  final Map<int, int> ladders = {
    1: 3, // Gratitude → Peace
    4: 8, // Hope → Strength
    5: 6, // Self Belief → Power
    7: 9, // Kindness → The Good Life
  };

  final Map<int, int> snakes = {
    2: 0, // Pressure → Back to square one
    3: 1, // Self Doubt → Gratitude
    8: 5, // Ego → Self Love (lesson)
  };

  void rollDice() {
    setState(() {
      diceValue = Random().nextInt(6) + 1;
      int nextPos = playerPosition + diceValue;
      if (nextPos >= boardTexts.length - 1) {
        nextPos = boardTexts.length - 1;
      }

      // Check for ladders or snakes
      if (ladders.containsKey(nextPos)) {
        nextPos = ladders[nextPos]!;
      } else if (snakes.containsKey(nextPos)) {
        nextPos = snakes[nextPos]!;
      }

      playerPosition = nextPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f5e3),
      appBar: AppBar(
        title: const Text(
          "Mindful Snake & Ladder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade300,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          // Board grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: boardTexts.length,
              itemBuilder: (context, index) {
                bool isPlayerHere = playerPosition == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isPlayerHere
                        ? Colors.orange.shade400
                        : Colors.yellow.shade100,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          boardTexts[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isPlayerHere
                                ? Colors.white
                                : Colors.brown.shade700,
                            fontSize: 16,
                            height: 1.2,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (isPlayerHere)
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.person, size: 28, color: Colors.white),
                        )
                    ],
                  ),
                );
              },
            ),
          ),

          // Roll Dice button + Dice Value
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: rollDice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "🎲 Roll Dice",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Dice Rolled: $diceValue",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  "Current Position: ${boardTexts[playerPosition]}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
