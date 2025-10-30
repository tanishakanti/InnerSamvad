import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveQuestionnaireResult({
    required String category,
    required int score,
    required String severity,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      final resultsRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('questionnaireResults')
          .doc(); // auto-ID for each result

      await resultsRef.set({
        'category': category,
        'score': score,
        'severity': severity,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("✅ Result saved: $category — $score");
    } catch (e) {
      print("❌ Error saving result: $e");
    }
  }
}
