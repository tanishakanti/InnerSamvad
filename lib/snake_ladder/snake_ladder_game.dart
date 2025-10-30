import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// ----------------------------------------------------------------------
// 1. INTEGRATED: question_data.dart 
// ----------------------------------------------------------------------
class QuestionSet {
  final String title;
  final List<Map<String, dynamic>> questions;

  QuestionSet({dynamic focused= true, required this.title, required this.questions});
}

// ------------------------- LADDER QUESTIONS (Opportunities for Growth) --------------------------
final Map<int, QuestionSet> ladderQuestions = {
  // Index 21: Self Belief (LADDER UP -> Index 5: Hope)
  21: QuestionSet(
    title: 'Self Belief',
    questions: [
      {
        'type': 'input',
        'question': 'What does self-belief mean for you?',
      },
      {
        'type': 'input',
        'question': 'Is self-belief important to you? If yes, why. If not, why?',
      },
      {
        'type': 'mcq',
        'question':
            'Rohan is scared to ask a question in class because he thinks others will laugh. What should he do?',
        'options': [
          'Stay silent and let his doubts remain',
          'Raise his hand, ask the question, and trust that it’s okay to seek clarity',
          'Wait for someone else to ask the same question',
          'Make a joke instead of asking seriously'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 8: Kindness (LADDER UP -> Index 15: Gratitude)
  8: QuestionSet(
    title: 'Kindness',
    questions: [
      {'type': 'input', 'question': 'What does being kind look like for you?'},
      {'type': 'input', 'question': 'What value does kindness hold in your life?'},
      {
        'type': 'mcq',
        'question': 'Someone is having a hard day. What do you do?',
        'options': [
          'Ignore them because everyone has problems to deal with',
          'Offer a small act of help or a kind word, even if it’s just a little gesture',
          'Wait until they ask for help, so I don’t get involved unnecessarily',
          'Only help if others are watching, so people see how kind I am'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 5: Hope (LADDER UP -> Index 10: Peace)
  5: QuestionSet(
    title: 'Hope',
    questions: [
      {'type': 'input', 'question': 'What comes to your mind when you hear the word ‘Hope’?'},
      {'type': 'input', 'question': 'Is ‘hope’ relevant in today’s time? If yes, why. If not, why?'},
      {
        'type': 'mcq',
        'question': 'Things aren’t going as planned, and I feel like giving up. What can I do?',
        'options': [
          'Keep thinking about everything that went wrong and feel stuck',
          'Take small steps toward what I can control and remind myself that better days are possible',
          'Rely completely on others to solve my problems',
          'Ignore the situation and distract myself so I don’t feel anything'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 18: Self-love (LADDER UP -> Index 1: Strength)
  18: QuestionSet(
    title: 'Self-love',
    questions: [
      {'type': 'input', 'question': 'Describe self-love using 5 words'},
      {'type': 'input', 'question': 'What does it mean to have self-love in one\'s life?'},
      {
        'type': 'mcq',
        'question': 'Which dialogue do you think describes self-love the best?',
        'options': [
          '‘Mein apni favourite hoon’',
          '‘Jab hum apne aap ko achchi tarah samajh lete hai ... toh doosre kya samajhte hai, it doesn\'t matter ... not at all’',
          '‘Keh diya na, bas keh diya’',
          '‘Mogambo khush hua’'
        ],
        'answerIndex': 1 
      }
    ],
  ),

  // Index 17: Power (LADDER UP -> Index 4: EGO)
  17: QuestionSet(
    title: 'Power',
    questions: [
      {'type': 'input', 'question': 'What is power according to you?'},
      {'type': 'input', 'question': 'How does the presence and/or absence of power impact a person\'s life?'},
      {
        'type': 'mcq',
        'question': 'Who would you consider to be a powerful person?',
        'options': [
          'Someone who forces others to listen to them',
          'Someone who has wealth but uses it only for themselves',
          'Someone who creates change by supporting, uplifting, and inspiring others',
          'Someone who hides their strengths and never shares them'
        ],
        'answerIndex': 2 
      }
    ],
  ),
  
  // Index 15: Gratitude (LADDER UP -> Index 10: Peace)
  15: QuestionSet(
    title: 'Gratitude',
    questions: [
      {'type': 'input', 'question': 'If you were to write the meaning of Gratitude in a dictionary, what would you write?'},
      {'type': 'input', 'question': 'Is gratitude important for you? If yes, why. If not, why?'},
      {
        'type': 'mcq',
        'question': 'When would you say ‘Thank You’ to someone?',
        'options': [
          'Only when you want something in return',
          'When you genuinely feel grateful for their help or kindness',
          'Only if the person is older or in authority',
          'When everyone else is saying it, even if you don’t mean it'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 10: Peace (LADDER UP -> Index 1: Strength)
  10: QuestionSet(
    title: 'Peace',
    questions: [
      {'type': 'input', 'question': 'How would you describe peace to someone so that they could understand what it means?'},
      {'type': 'input', 'question': 'Is peace of any personal significance to you? If yes, why. If not, why?'},
      {
        'type': 'mcq',
        'question': 'What is peaceful?',
        'options': [
          'When everything is quiet around you, even if your thoughts are noisy',
          'When life gives you no problems at all',
          'When your mind and heart feel calm, even while life has its ups and downs',
          'When everyone always agrees with you and nothing changes'
        ],
        'answerIndex': 2
      }
    ],
  ),
  
  // Index 1: Strength (LADDER UP -> Index 0: The Good Life!)
  1: QuestionSet(
    title: 'Strength',
    questions: [
      {'type': 'input', 'question': 'What does it mean to be strong?'},
      {'type': 'input', 'question': 'How important or unimportant is it to be strong, according to you?'},
      {
        'type': 'mcq',
        'question': 'Which statement about strength is true?',
        'options': [
          'Strength is only about muscles or physical ability',
          'Strength can be mental, emotional, social, or physical',
          'Strength means never feeling fear or sadness',
          'Strength is about always being the best at everything'
        ],
        'answerIndex': 1
      }
    ],
  ),
};

// ------------------------- SNAKE QUESTIONS (Challenges/Setbacks) --------------------------
final Map<int, QuestionSet> snakeQuestions = {
  // Index 4: Ego (SNAKE DOWN -> Index 19: baby steps)
  4: QuestionSet(
    title: 'Ego',
    questions: [
      {'type': 'input', 'question': 'What is the meaning of ego according to you?'},
      {'type': 'input', 'question': 'Is Ego good or bad? Why?'},
      {
        'type': 'mcq',
        'question': 'What does an egoistic person look like?',
        'options': [
          'Someone who listens carefully and values others’ opinions before making decisions',
          'Someone who always wants to be the center of attention and believes their ideas are more important than others’',
          'Someone who quietly helps others without expecting anything in return',
          'Someone who occasionally expresses their thoughts but respects everyone equally'
        ],
        'answerIndex': 1
      }
    ],
  ),

  // Index 2: Comparison (SNAKE DOWN -> Index 13: baby steps)
  2: QuestionSet(
    title: 'Comparison',
    questions: [
      {'type': 'input', 'question': 'Give a personal example describing your understanding of comparison.'},
      {'type': 'input', 'question': 'Do you compare yourself with others? If yes, how. If not, how?'},
      {
        'type': 'mcq',
        'question': 'Your friend always compares their social media posts to their friends’ posts and feels inadequate. What is the best approach?',
        'options': [
          'Keep scrolling and feel worse every day.',
          'Limit social media use and focus on sharing things that make them genuinely happy.',
          'Copy their friends’ posts to get the same attention.',
          'Stop posting anything ever again.'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 23: Stagnation (SNAKE DOWN -> Index 14: baby steps)
  23: QuestionSet(
    title: 'Stagnation',
    questions: [
      {'type': 'input', 'question': 'What is the meaning of the word ‘stagnation’ according to you?'},
      {'type': 'input', 'question': 'Is stagnation part of your life? If yes, how. If not, how?'},
      {
        'type': 'mcq',
        'question': 'If you were in a situation where you were not able to move from, for example, stuck in quick sand, what would you do to get out of it?',
        'options': [
          'Do nothing and accept/succumb to your fate',
          'Rely only and only on yourself, without taking any help, to get out without any guarantee that you will succeed',
          'Do nothing and wait only till someone comes to ‘rescue’',
          'Put in as much effort as possible by yourself and seek out help which can assist you in moving out of the given situation.'
        ],
        'answerIndex': 3
      }
    ],
  ),
  
  // Index 11: Pressure (SNAKE DOWN -> Index 24: baby steps)
  11: QuestionSet(
    title: 'Pressure',
    questions: [
      {'type': 'input', 'question': 'Give 3 words that are similar to pressure according to you.'},
      {'type': 'input', 'question': 'Is pressure helpful, harmful, or both? Give reasons for your choice'},
      {
        'type': 'mcq',
        'question': 'There is pressure on my bladder. What should I do?',
        'options': [
          'Keep holding it because “it’s not that urgent”',
          'Drink lots of water quickly, hoping it will somehow fix itself',
          'Go to a restroom and urinate as soon as possible to relieve the pressure',
          'Distract yourself with other activities until it goes away'
        ],
        'answerIndex': 2
      }
    ],
  ),
  
  // Index 12: Self-doubt (SNAKE DOWN -> Index 22: baby steps)
  12: QuestionSet(
    title: 'Self-doubt',
    questions: [
      {'type': 'input', 'question': 'What does self - doubt mean?'},
      {'type': 'input', 'question': 'Does self-doubt contribute to your life? If yes, why. If not, why not?'},
      {
        'type': 'mcq',
        'question': 'I feel self-doubt. What should I do?',
        'options': [
          'Ignore it completely and pretend I’m confident, even if I feel unsure inside',
          'Compare myself to others and feel worse about my abilities',
          'Pause, reflect on my strengths, and take small steps to build confidence',
          'Avoid trying anything new to stay “safe” and prevent failure'
        ],
        'answerIndex': 2
      }
    ],
  ),
};

// ----------------------------------------------------------------------
// 2. MODIFIED: question_dialogs.dart (Scrollability & Data Capture)
// ----------------------------------------------------------------------
Future<bool> showQuestionDialogSet(
  BuildContext context, 
  QuestionSet qSet,
  List<Map<String, dynamic>> sessionAnswers 
) async {
  bool allCorrect = true;

  for (var q in qSet.questions) {
    if (q['type'] == 'input') {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          TextEditingController ctrl = TextEditingController();
          return AlertDialog(
            backgroundColor: Colors.blue.shade50,
            title: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text('Reflect on ${qSet.title}', style: TextStyle(color: Colors.blue.shade700)),
              ],
            ),
            // Scrollable Content
            content: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      q['question'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TextField(
                    controller: ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Type your reflection here...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5, 
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Capture the reflection input for Firebase
                  sessionAnswers.add({
                    'type': 'reflection',
                    'tileTitle': qSet.title,
                    'question': q['question'],
                    'answerText': ctrl.text, // Store the user's input
                    'timestamp': DateTime.now().toIso8601String(),
                  });
                  Navigator.pop(context);
                },
                child: const Text("Journey Onward", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      );
    } else if (q['type'] == 'mcq') {
      // Multiple Choice Question Dialog (Enhanced Scrollability & Capture)
      int? selected;
      bool correct = false;
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.quiz, color: Colors.blue.shade700),
                  const SizedBox(width: 14, height: 10),
                  Expanded(
                    child: Text(
                      'The ${qSet.title} Challenge!',
                      style: TextStyle(color: Colors.blue.shade700),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              // Scrollable Content
              content: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        q['question'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    ...List.generate(q['options'].length, (i) {
                      return RadioListTile<int>(
                        dense: true,
                        title: Text(q['options'][i], style: const TextStyle(fontSize: 14)),
                        value: i,
                        groupValue: selected,
                        onChanged: (val) => setState(() => selected = val),
                      );
                    }),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: selected != null
                      ? () {
                          correct = (selected == q['answerIndex']);
                          
                          // Capture the MCQ answer for Firebase
                          sessionAnswers.add({
                            'type': 'mcq',
                            'tileTitle': qSet.title,
                            'question': q['question'],
                            'selectedOptionIndex': selected,
                            'selectedOptionText': q['options'][selected!],
                            'correctAnswerIndex': q['answerIndex'],
                            'isCorrect': correct,
                            'timestamp': DateTime.now().toIso8601String(),
                          });

                          Navigator.pop(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text("Submit Answer", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          });
        },
      );
      if (!correct) allCorrect = false;
    }
  }
  return allCorrect;
}

// ----------------------------------------------------------------------
// 3. MODIFIED: BoardScreenState (Dice Roll Logic Changed)
// ----------------------------------------------------------------------
class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  int _currentPositionIndex = 24; // Start at 24
  int _diceRoll = 0;
  String _message = 'Tap "Roll" to start the journey!';
  final Random _random = Random();
  final int gridSize = 5; 

  // Firebase data storage
  String? _sessionId;
  List<Map<String, dynamic>> _sessionAnswers = [];
  
  String _getCurrentUserId() {
    // Uses Firebase Auth UID or a timestamp-based fallback for anonymous users
    return FirebaseAuth.instance.currentUser?.uid ?? 'anonymous_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> _saveSessionToFirebase() async {
    if (_sessionAnswers.isEmpty || _sessionId == null) return;

    try {
      final userId = _getCurrentUserId();
      final sessionData = {
        'sessionId': _sessionId,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'finalPosition': _currentPositionIndex,
        'answers': _sessionAnswers,
      };

      await FirebaseFirestore.instance
          .collection('game_sessions')
          .doc(_sessionId)
          .set(sessionData);
          
      // Ensure the message shows the save status
      if (_currentPositionIndex == 0) {
        setState(() {
            _message = 'YOU HAVE REACHED THE GOOD LIFE! Session data saved successfully. 🎉';
        });
      } else {
        // This case should ideally not happen based on current logic, but keeps it safe
        print("Answers saved mid-game.");
      }

    } catch (e) {
      print("Error saving to Firestore. Ensure Firebase is initialized: $e");
      // Update message to user about the failure only if they reached the goal
      if (_currentPositionIndex == 0) {
        setState(() {
          _message = 'YOU HAVE REACHED THE GOOD LIFE! Failed to save answers (Firebase error).';
        });
      }
    }
  }


  final List<Map<String, dynamic>> boardItems = [
    // Row 1 (y=0) - Indices 0-4
    {'text': 'the\nGood\nLife!', 'color': Colors.yellow.shade700, 'x': 0, 'y': 0}, // 0 (Goal)
    {'text': 'Strength', 'color': Colors.lightGreen, 'x': 1, 'y': 0}, // 1 (Ladder Q)
    {'text': 'Comparison', 'color': Colors.yellow.shade700, 'x': 2, 'y': 0}, // 2 (Snake Q)
    {'text': 'baby steps', 'color': Colors.pink.shade300, 'x': 3, 'y': 0}, // 3
    {'text': 'EGO', 'color': Colors.purple.shade700, 'x': 4, 'y': 0}, // 4 (Snake Q)

    // Row 2 (y=1) - Indices 5-9
    {'text': 'Hope', 'color': Colors.blue.shade100, 'x': 0, 'y': 1}, // 5 (Ladder Q)
    {'text': 'baby steps', 'color': Colors.yellow.shade700, 'x': 1, 'y': 1}, // 6
    {'text': 'baby steps', 'color': Colors.yellow.shade100, 'x': 2, 'y': 1}, // 7
    {'text': 'Kindness', 'color': Colors.grey.shade300, 'x': 3, 'y': 1}, // 8 (Ladder Q)
    {'text': 'baby steps', 'color': Colors.yellow.shade700, 'x': 4, 'y': 1}, // 9

    // Row 3 (y=2) - Indices 10-14
    {'text': 'Peace', 'color': Colors.green.shade100, 'x': 0, 'y': 2}, // 10 (Ladder Q)
    {'text': 'Pressure', 'color': Colors.yellow.shade700, 'x': 1, 'y': 2}, // 11 (Snake Q)
    {'text': 'Self Doubts', 'color': Colors.pink.shade300, 'x': 2, 'y': 2}, // 12 (Snake Q)
    {'text': 'baby steps', 'color': Colors.yellow.shade700, 'x': 3, 'y': 2}, // 13
    {'text': 'baby steps', 'color': Colors.yellow.shade700, 'x': 4, 'y': 2}, // 14

    // Row 4 (y=3) - Indices 15-19
    {'text': 'Gratitude', 'color': Colors.orange.shade100, 'x': 0, 'y': 3}, // 15 (Ladder Q)
    {'text': 'Baby steps', 'color': Colors.yellow.shade700, 'x': 1, 'y': 3}, // 16
    {'text': 'Power', 'color': Colors.yellow.shade700, 'x': 2, 'y': 3}, // 17 (Ladder Q)
    {'text': 'Self Love', 'color': Colors.pink.shade300, 'x': 3, 'y': 3}, // 18 (Ladder Q)
    {'text': 'baby steps', 'color': Colors.yellow.shade100, 'x': 4, 'y': 3}, // 19

    // Row 5 (y=4) - Indices 20-24
    // Corrected to match question sets (21=Self Belief, 23=Stagnation)
    {'text': 'Baby Steps', 'color': Colors.brown.shade100, 'x': 0, 'y': 4}, // 20 
    {'text': 'Self Belief', 'color': Colors.blueGrey.shade100, 'x': 1, 'y': 4}, // 21 (Ladder Q)
    {'text': 'Baby Steps', 'color': Colors.blueGrey.shade100, 'x': 2, 'y': 4}, // 22
    {'text': 'Stagnation', 'color': Colors.red.shade100, 'x': 3, 'y': 4}, // 23 (Snake Q)
    {'text': 'The Start', 'color': Colors.grey.shade300, 'x': 4, 'y': 4}, // 24 (Start)
  ];

  final Map<int, int> jumpsAndDrops = {
    // --- LADDERS (Jump UP - destination < currentPos) ---
    21: 17, 
    18: 8, 
    15: 10, 
    5: 1, 
    
    // --- SNAKES (Drop DOWN - destination > currentPos) ---
    4: 23, 
    2: 11, 
    12: 21, 
    23: 14, 
  };

  void _resetGame() {
    setState(() {
      _currentPositionIndex = 24; // Reset to the starting position
      _diceRoll = 0;
      _message = 'Tap "Roll" to start the journey!';
      _sessionId = null; 
      _sessionAnswers.clear(); 
    });
  }


  Future<void> _rollDice() async {
    if (_currentPositionIndex == 0) {
      setState(() => _message = 'You have reached the Good Life! Press Restart to play again.');
      return;
    }

    // 1. Initialize session if this is the first roll
    if (_sessionId == null) {
      _sessionId = 'session_${DateTime.now().millisecondsSinceEpoch}';
      _sessionAnswers.clear();
    }

    final rollValue = _random.nextInt(6) + 1;
    final stepsToGoal = _currentPositionIndex;
    final currentSquare = boardItems[_currentPositionIndex]['text'];
    
    // --- NEW LOGIC: Prevent Overshoot/Bounce-back near Goal (Tile 0) ---
    if (rollValue > stepsToGoal) {
      // Overshoot: Roll is too high. Stay put on the current tile.
      setState(() {
        _diceRoll = rollValue;
        _message = 'Rolled a $rollValue. You need exactly $stepsToGoal steps to reach The Good Life (0)! Staying at $currentSquare. Roll again.';
      });
      await Future.delayed(const Duration(milliseconds: 350));
      // End the turn here, skipping all movement and question logic.
      return; 
    }
    // -----------------------------------------------------------------
    
    // Standard move (Exact hit or Undershoot)
    int newPosition = _currentPositionIndex - rollValue; 

    // 2. Apply the calculated move
    setState(() {
      _diceRoll = rollValue;
      _message = 'Rolled a $rollValue. Moving from $currentSquare...';
      _currentPositionIndex = newPosition;
    });

    await Future.delayed(const Duration(milliseconds: 350));
    
    int currentPos = _currentPositionIndex;
    String landedSquare = boardItems[currentPos]['text'];

    // 3. Final check for the Goal, save data if reached
    if (currentPos == 0) {
        await _saveSessionToFirebase();
        return; // Game over, exit turn.
    }
    
    // 4. Check for Jumps/Drops
    if (jumpsAndDrops.containsKey(currentPos)) {
      
      int destination = jumpsAndDrops[currentPos]!;
      bool isLadder = (destination < currentPos);
      
      QuestionSet? qSet = isLadder 
          ? ladderQuestions[currentPos] 
          : snakeQuestions[currentPos];
      
      if (qSet != null) {
        // CALL DIALOG: Pass the answers list
        bool passedQuestions = await showQuestionDialogSet(context, qSet, _sessionAnswers);
        
        setState(() {
          if (passedQuestions) {
            if (isLadder) {
              _currentPositionIndex = destination;
              _message = '🎉 Success! Understood ${qSet!.title} and **climbed** to ${boardItems[_currentPositionIndex]['text']}!';
            } else {
              _message = '✅ Awareness! Understood ${qSet!.title} and dodged the setback. Staying at $landedSquare.';
            }
          } else {
            if (!isLadder) {
              _currentPositionIndex = destination;
              _message = '😥 Setback! Failed ${qSet!.title} questions and **slid back** to ${boardItems[_currentPositionIndex]['text']}.';
            } else {
              _message = '⚠️ Missed chance! Failed ${qSet!.title} questions. **Staying at $landedSquare**, but the path ahead remains steep.';
            }
          }
        });
      }
    } else {
      // Standard message for landing on a normal tile
      setState(() {
        _message += '\nLanded on $landedSquare.';
      });
    }
  }

  // --- UI HELPER: Calculate the exact position for the player icon ---
  Offset _getPlayerPositionOffset(double boardSize) {
    Map<String, dynamic> currentItem = boardItems[_currentPositionIndex];
    final squareSize = boardSize / gridSize;
    final x = currentItem['x'] as int;
    final y = currentItem['y'] as int;

    final left = x * squareSize + squareSize / 2;
    final top = y * squareSize + squareSize / 2;

    return Offset(left, top);
  }


  // --- FLUTTER UI (Build Method) ---
  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width * 0.9;
    final iconOffset = _getPlayerPositionOffset(boardSize);
    final squareSize = boardSize / gridSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Life's Board Game (Interactive)"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // 1. Game Board Display (The Stack)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Container(
                width: boardSize,
                height: boardSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: const Color(0xFFFAE0A5), 
                ),
                child: Stack(
                  children: [
                    // --- Draw the main 5x5 squares/elements ---
                    ...boardItems.map((item) {
                      final left = item['x'] * squareSize;
                      final top = item['y'] * squareSize;

                      return Positioned(
                        left: left,
                        top: top,
                        width: squareSize,
                        height: squareSize,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(
                            child: Container(
                              width: squareSize * 0.8,
                              height: squareSize * 0.8,
                              decoration: BoxDecoration(
                                color: item['color'] as Color,
                                borderRadius: BorderRadius.circular(squareSize * 0.4),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26, spreadRadius: 1, blurRadius: 3, offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item['text'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: squareSize * 0.12, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    // --- User Icon to Visualize Current Location ---
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: iconOffset.dx - 15, 
                      top: iconOffset.dy - 15,  
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 4)],
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // 2. Dice Roll and Message Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Current Square and Message
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        _message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),

                  // Dice Display
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _diceRoll == 0 ? '?' : _diceRoll.toString(),
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Roll/Game Over Buttons
                  SizedBox(
                    width: double.infinity,
                    child: _currentPositionIndex == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _resetGame,
                                  icon: const Icon(Icons.refresh),
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text('Restart Game', style: TextStyle(fontSize: 18)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => Navigator.pop(context), 
                                  icon: const Icon(Icons.exit_to_app),
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text('Exit', style: TextStyle(fontSize: 18)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade700,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ElevatedButton.icon(
                            onPressed: _rollDice,
                            icon: const Icon(Icons.casino),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Roll of Life',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}