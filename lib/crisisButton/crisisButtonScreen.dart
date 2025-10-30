import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrisisButtonScreen extends StatelessWidget {
  const CrisisButtonScreen({super.key});

  // Function to make a phone call
  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not launch $phoneNumber"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // ✅ Fetch emergency contact from Firestore
  Future<String?> _fetchEmergencyContact() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data()!.containsKey('emergencyContact')) {
        return doc['emergencyContact'];
      }
    } catch (e) {
      debugPrint('Error fetching emergency contact: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB3E5FC), // soft blue
              Color(0xFFE1F5FE), // lighter blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Title
                Text(
                  "Crisis Button",
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  "Get emergency support with ONE CLICK",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 40),

                // Quick Button
                _buildCrisisOption(
                  icon: Icons.flash_on,
                  title: "Quick",
                  subtitle: "Connect with a helpline for support today",
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => _makePhoneCall(context, "14416"),
                ),

                const SizedBox(height: 20),

                // ✅ Talk with a human (Fetch number from Firestore)
                _buildCrisisOption(
                  icon: Icons.people,
                  title: "Talk with a human",
                  subtitle: "Connect with your closed ones",
                  gradient: const LinearGradient(
                    colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () async {
                    final number = await _fetchEmergencyContact();
                    if (number != null && number.isNotEmpty) {
                      _makePhoneCall(context, number);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No emergency contact found"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // Talk with a professional
                _buildCrisisOption(
                  icon: Icons.verified_user,
                  title: "Talk with a professional",
                  subtitle: "Connect with our specialized professionals",
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => _makePhoneCall(context, "9004838515"),
                ),

                const Spacer(),

                // Footer
                const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 32,
                ),
                const SizedBox(height: 8),
                const Text(
                  "You are not alone",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCrisisOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
