import 'package:flutter/material.dart';
import 'package:inner_samvad/questionaire/models/question_model.dart';
import 'package:inner_samvad/questionaire/result_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String title;
  final List<Question> questions;

  const QuestionnaireScreen({super.key, required this.title, required this.questions});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int currentIndex = 0;
  int totalScore = 0;
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];
    final bgStart = const Color.fromARGB(255, 175, 215, 240);
    final bgEnd = const Color.fromARGB(255, 234, 240, 246);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [bgStart, bgEnd], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar with title and back
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "${widget.title} Questionnaire",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              // Progress indicator with animated width
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: (currentIndex + 1) / widget.questions.length),
                    duration: const Duration(milliseconds: 450),
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 6,
                        backgroundColor: Colors.white.withOpacity(0.7),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Question card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Question ${currentIndex + 1}/${widget.questions.length}",
                            style: const TextStyle(color: Colors.black54)),
                        const SizedBox(height: 8),
                        Text(
                          question.questionText,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 18),
                        // Options as selectable tiles
                        ...List.generate(question.options.length, (index) {
                          final isSelected = selectedOption == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: InkWell(
                              onTap: () => setState(() => selectedOption = index),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.blue.shade50 : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                                    width: isSelected ? 1.2 : 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.blue.shade50.withOpacity(0.6),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // custom radio circle
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade500,
                                          width: 2,
                                        ),
                                      ),
                                      child: isSelected
                                          ? Center(
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade700,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        question.options[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const Spacer(),
                        // Next button description
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: selectedOption == null
                                    ? null
                                    : () {
                                        // preserve original logic: increment totalScore with selected option's score
                                        totalScore += question.scores[selectedOption!];
                                        if (currentIndex < widget.questions.length - 1) {
                                          setState(() {
                                            currentIndex++;
                                            selectedOption = null;
                                          });
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ResultScreen(title: widget.title, score: totalScore),
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 6,
                                  backgroundColor: selectedOption == null ? Colors.grey.shade300 : Colors.blue.shade700,
                                ),
                                child: Text(
                                  currentIndex < widget.questions.length - 1 ? "Next" : "Finish",
                                  style: TextStyle(
                                    color: selectedOption == null ? Colors.grey.shade600 : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
