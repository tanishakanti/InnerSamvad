import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// --- Color Scheme ---
final bgStart = const Color.fromARGB(255, 175, 215, 240);
final bgEnd = const Color.fromARGB(255, 234, 240, 246);
const Color _primaryBlue = Color(0xFF1E88E5);
const Color _accentBlue = Color(0xFF42A5F5);

// --- Utility Widgets ---
class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, left: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: _primaryBlue,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// --- Settings Screen ---
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isPushNotificationsEnabled = true;
  TextEditingController _emergencyController = TextEditingController();
  User? user;
  String userEmail = '';
  String userName = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      userEmail = user!.email ?? '';
      // Fetch additional data from Firestore
      final doc = await _firestore.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        setState(() {
          userName = doc['name'] ?? '';
          _emergencyController.text = doc['emergencyContact'] ?? '';
        });
      }
    }
  }

  Future<void> _updateEmergencyContact(String contact) async {
    if (user != null) {
      await _firestore.collection('users').doc(user!.uid).set({
        'emergencyContact': contact,
      }, SetOptions(merge: true));
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Emergency contact updated')));
    }
  }

  Future<void> _updateAccountDetails(String newName, String newEmail) async {
    if (user != null) {
      try {
        if (newEmail != user!.email) {
          await user!.updateEmail(newEmail);
        }
        await _firestore.collection('users').doc(user!.uid).set({
          'name': newName,
        }, SetOptions(merge: true));

        setState(() {
          userEmail = newEmail;
          userName = newName;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Account updated')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login'); // go to login page
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Emergency Contact"),
          content: TextField(
            controller: _emergencyController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Enter emergency number",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _updateEmergencyContact(_emergencyController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showAccountDialog() {
    TextEditingController nameController =
        TextEditingController(text: userName);
    TextEditingController emailController =
        TextEditingController(text: userEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Account Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _updateAccountDetails(
                    nameController.text, emailController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgStart, bgEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          elevation: 0,
          titleTextStyle: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'EMERGENCY'),
              SettingTile(
                title: 'Emergency Contact',
                subtitle: _emergencyController.text.isEmpty
                    ? 'Add a number to call in a crisis.'
                    : _emergencyController.text,
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
                onTap: _showEmergencyDialog,
              ),
              const SectionHeader(title: 'NOTIFICATIONS'),
              SettingTile(
                title: 'Push Notifications',
                subtitle: 'For reminders and updates.',
                trailing: Switch(
                  value: _isPushNotificationsEnabled,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isPushNotificationsEnabled = newValue;
                    });
                  },
                  activeColor: _accentBlue,
                ),
                onTap: () {
                  setState(() {
                    _isPushNotificationsEnabled = !_isPushNotificationsEnabled;
                  });
                },
              ),
              const SectionHeader(title: 'ACCOUNT'),
              SettingTile(
                title: 'Account Details',
                subtitle: '$userName\n$userEmail',
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
                onTap: _showAccountDialog,
              ),
              SettingTile(
                title: 'Sign Out',
                subtitle: 'Sign out of your account.',
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
                onTap: _signOut,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          selectedItemColor: _primaryBlue,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Journal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            print("Tapped tab index: $index");
          },
        ),
      ),
    );
  }
}
