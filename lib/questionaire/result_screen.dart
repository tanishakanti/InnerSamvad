import 'package:flutter/material.dart';
import 'package:inner_samvad/questionaire/services/firestore_service.dart';

class ResultScreen extends StatefulWidget {
  final String title;
  final int score;

  const ResultScreen({super.key, required this.title, required this.score});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? _severity;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _severity = getSeverity();
    // save result but keep UI responsive
    saveToFirestore();
  }

  String getSeverity() {
    if (widget.score <= 7) return "Minimal ${widget.title}";
    if (widget.score <= 9) return "Mild ${widget.title}";
    if (widget.score <= 14) return "Moderate ${widget.title}";
    if (widget.score <= 19) return "Moderately severe ${widget.title}";
    return "Severe ${widget.title}";
  }

  Future<void> saveToFirestore() async {
    await FirestoreService().saveQuestionnaireResult(
      category: widget.title,
      score: widget.score,
      severity: _severity!,
    );
    if (mounted) setState(() => _isSaved = true);
  }

  @override
  Widget build(BuildContext context) {
    final bgStart = const Color.fromARGB(255, 175, 215, 240);
    final bgEnd = const Color.fromARGB(255, 234, 240, 246);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [bgStart, bgEnd], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "${widget.title} Result",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Your Assessment Result",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Icon(
                              _severity != null && _severity!.toLowerCase().contains("severe")
                                  ? Icons.priority_high_rounded
                                  : Icons.check_circle_outline_rounded,
                              size: 48,
                              color: _severity != null && _severity!.toLowerCase().contains("severe")
                                  ? Colors.redAccent
                                  : Colors.green,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _severity ?? "Calculating...",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              "Score: ${widget.score}",
                              style: const TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            const SizedBox(height: 18),
                            _isSaved
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.lock_open, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text(
                                        "Result saved securely for your doctor.",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                            const SizedBox(height: 18),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 6,
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Back to Home"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
