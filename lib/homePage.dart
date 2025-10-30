import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final emojis = [
    {'emoji': '😊', 'label': 'Happy', 'message': 'Keep shining! You’re doing great! ☀️'},
    {'emoji': '😌', 'label': 'Calm', 'message': 'Inner peace is your superpower. 🌿'},
    {'emoji': '😐', 'label': 'Okay', 'message': 'Every day doesn’t have to be perfect. 🌸'},
    {'emoji': '😔', 'label': 'Sad', 'message': 'It’s okay to feel sad sometimes. You matter 💙'},
    {'emoji': '😠', 'label': 'Angry', 'message': 'Take a deep breath… You’ve got this. 🌬️'},
  ];

  void _onMoodTap(String mood, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(mood, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        // Home
        break;
      case 1:
        Navigator.pushNamed(context, '/snakeandladder');
        break;
      case 2:
        Navigator.pushNamed(context, '/appointmentBookScreen');
        break;
      case 3:
        Navigator.pushNamed(context, '/moodTracker');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Welcome back,", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Sarah", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/settingPage');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
                      ),
                      child: const Icon(Icons.settings, color: Colors.black87),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Daily Tip
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFD8F9F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Daily Well-being Tip",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.teal),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Start your day with a moment of stillness.\nJust 5 minutes of quiet can make a difference.",
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.lightbulb_outline, color: Colors.teal, size: 28),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Tabs Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _tabItem("For You", true, () {
                    Navigator.pushNamed(context, '/homePage');
                  }),
                  _tabItem("Questionaire", false, () {
                    Navigator.pushNamed(context, '/questionaire');
                  }),
                  _tabItem("Mood Tracker", false, () {
                    Navigator.pushNamed(context, '/moodTracker');
                  }),
                  _tabItem("Knowledge Hub", false, () {
                    Navigator.pushNamed(context, '/knowledgeHub');
                  }),
                ],
              ),

              const SizedBox(height: 25),

              const Text("How are you feeling today?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const SizedBox(height: 15),

              // Mood Emojis
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: emojis
                      .map(
                        (e) => GestureDetector(
                          onTap: () => _onMoodTap(e['label']!, e['message']!),
                          child: Column(
                            children: [
                              Text(e['emoji']!, style: const TextStyle(fontSize: 28)),
                              const SizedBox(height: 4),
                              Text(e['label']!,
                                  style: const TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 25),

              // Mental Wellness Games
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/snakeandladder');
                },
                child: _imageCard(
                  imagePath: 'assets/images/mental_games.png',
                  title: "Mental Wellness Game",
                  subtitle: "Engage in fun, interactive games to boost your mental well-being.",
                ),
              ),

              const SizedBox(height: 20),

              // Appointment Booking
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/appointmentBookScreen');
                },
                child: _imageCard(
                  imagePath: 'assets/images/appointment.png',
                  title: "Appointment Booking",
                  subtitle: "Schedule sessions with licensed therapists at your convenience.",
                ),
              ),

              const SizedBox(height: 20),

              // Two Small Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _smallCard(Icons.description, "Questionnaire", "Check in with yourself", () {
                    Navigator.pushNamed(context, '/questionaire');
                  }),
                  _smallCard(Icons.music_note, "Soothing Sounds", "For deep relaxation", () {
                    Navigator.pushNamed(context, '/soothingPage');
                  }),
                ],
              ),

              const SizedBox(height: 25),

              // Crisis Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/crisisButton');
                },
                icon: const Icon(Icons.support, color: Colors.white),
                label: const Text(
                  "Crisis & Emergency Support",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: 'Game'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
        ],
      ),
    );
  }

  Widget _tabItem(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: selected ? Colors.teal : Colors.grey,
            ),
          ),
          if (selected)
            Container(
              height: 3,
              width: 30,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }

  Widget _imageCard({required String imagePath, required String title, required String subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallCard(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.teal, size: 28),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages for navigation
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("$title Page Coming Soon!", style: const TextStyle(fontSize: 18))),
    );
  }
}
