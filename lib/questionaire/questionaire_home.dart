import 'package:flutter/material.dart';
import 'package:inner_samvad/questionaire/data/anxietyQuestions.dart';
import 'package:inner_samvad/questionaire/data/depressionQuestions.dart';
import 'package:inner_samvad/questionaire/data/generalhealthQuestions.dart';
import 'package:inner_samvad/questionaire/models/question_model.dart';
import 'questionnaire_screen.dart';

class QuestionnaireHome extends StatelessWidget {
  const QuestionnaireHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bgStart = const Color.fromARGB(255, 175, 215, 240);
    final bgEnd = const Color.fromARGB(255, 234, 240, 246);

    return Scaffold(
      backgroundColor: Colors.transparent,
      // Using a gradient background container
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgStart, bgEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Questionnaire",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Title
                const Text(
                  "How are you feeling today?",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Select a category to start your questionnaire.",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 22),
                // Categories list
                buildCategory(context, "Depression", depressionQuestions,
                    icon: Icons.self_improvement_outlined),
                const SizedBox(height: 14),
                buildCategory(context, "Anxiety", anxietyQuestions,
                    icon: Icons.speaker_notes_off_outlined),
                const SizedBox(height: 14),
                buildCategory(context, "General Health", generalHealthQuestions,
                    icon: Icons.health_and_safety_outlined),
                // Spacer to push content up
                const Spacer(),
                // Helpful footer / subtle hint
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline, size: 18),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your answers are confidential and securely stored for your doctor.",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategory(BuildContext context, String title, List<Question> questions,
      {IconData? icon}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionnaireScreen(title: title, questions: questions),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Icon(icon ?? Icons.circle_outlined, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 14),
            // Title & subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                  const SizedBox(height: 4),
                  Text("${questions.length} questions", style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
