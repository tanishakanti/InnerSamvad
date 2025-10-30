import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class SoothingSoundsPage extends StatefulWidget {
 const SoothingSoundsPage({super.key});


 @override
 _SoothingSoundsPageState createState() => _SoothingSoundsPageState();
}


class _SoothingSoundsPageState extends State<SoothingSoundsPage>
   with SingleTickerProviderStateMixin {
 late TabController _tabController;
 final AudioPlayer _player = AudioPlayer();
 bool _isPlaying = false;
 String _currentSound = "";
 final _volume = 0.6;


 double _timerValue = 30; // minutes
 Duration _remainingTime = Duration.zero;
 Timer? _countdownTimer;


 Set<String> likedSounds = {}; // For liked tab


 final List<Map<String, dynamic>> natureSounds = [
   {"icon": Icons.water_drop, "title": "Gentle Rain", "file": "rain"},
   {"icon": Icons.waves, "title": "Ocean", "file": "ocean"},
   {"icon": Icons.park, "title": "Forest", "file": "forest"},
   {"icon": Icons.air, "title": "Wind", "file": "wind"},
 ];


 final List<Map<String, dynamic>> instrumentalSounds = [
   {"icon": Icons.music_note, "title": "Piano", "file": "piano"},
   {"icon": Icons.queue_music, "title": "Guitar", "file": "guitar"},
   {"icon": Icons.library_music, "title": "Flute", "file": "flute"},
   {"icon": Icons.music_video, "title": "Harp", "file": "harp"},
 ];


 final List<Map<String, dynamic>> meditationSounds = [
   {"icon": Icons.self_improvement, "title": "Chanting", "file": "chant"},
   {"icon": Icons.spa, "title": "Bells", "file": "bells"},
   {"icon": Icons.yard, "title": "Om Vibes", "file": "om"},
   {"icon": Icons.accessibility_new, "title": "Deep Focus", "file": "focus"},
 ];


 @override
 void initState() {
   super.initState();
   _tabController = TabController(length: 4, vsync: this);
   _player.setVolume(_volume);
 }


 Future<void> playSound(String sound) async {
   if (_isPlaying && _currentSound == sound) {
     await _player.pause();
     _pauseCountdown();
     setState(() => _isPlaying = false);
   } else {
     await _player.stop();


     // ✅ Play local asset sound
     await _player.play(AssetSource("sounds/$sound.mp3"));


     setState(() {
       _isPlaying = true;
       _currentSound = sound;
       _remainingTime = Duration(minutes: _timerValue.toInt());
     });


     _startCountdown();
   }
 }


 void _startCountdown() {
   _countdownTimer?.cancel();
   _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
     if (_remainingTime.inSeconds > 0) {
       setState(() => _remainingTime -= const Duration(seconds: 1));
     } else {
       await _player.stop();
       timer.cancel();
       setState(() {
         _isPlaying = false;
         _currentSound = "";
       });
     }
   });
 }


 void _pauseCountdown() => _countdownTimer?.cancel();


 void _resumeCountdown() {
   if (_remainingTime.inSeconds > 0) _startCountdown();
 }


 void _toggleLike(String sound) {
   setState(() {
     if (likedSounds.contains(sound)) {
       likedSounds.remove(sound);
     } else {
       likedSounds.add(sound);
     }
   });
 }


 String formatDuration(Duration duration) {
   String twoDigits(int n) => n.toString().padLeft(2, '0');
   final minutes = twoDigits(duration.inMinutes.remainder(60));
   final seconds = twoDigits(duration.inSeconds.remainder(60));
   return "$minutes:$seconds";
 }


 Widget buildSoundCard(IconData icon, String title, String soundFile) {
   bool isActive = _currentSound == soundFile && _isPlaying;
   bool isLiked = likedSounds.contains(soundFile);


   return GestureDetector(
     onTap: () => playSound(soundFile),
     child: Container(
       decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.85),
         borderRadius: BorderRadius.circular(18),
         boxShadow: const [
           BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2)),
         ],
         border: Border.all(
           color: isActive ? Colors.teal : Colors.transparent,
           width: 1.5,
         ),
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(icon, size: 40, color: Colors.teal.shade700),
           const SizedBox(height: 10),
           Text(title,
               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
           const SizedBox(height: 10),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(
                 isActive ? Icons.pause_circle_filled : Icons.play_circle_fill,
                 color: Colors.teal,
                 size: 32,
               ),
               const SizedBox(width: 16),
               GestureDetector(
                 onTap: () => _toggleLike(soundFile),
                 child: Icon(
                   isLiked ? Icons.favorite : Icons.favorite_border,
                   color: isLiked ? Colors.pink : Colors.black45,
                   size: 26,
                 ),
               ),
             ],
           ),
         ],
       ),
     ),
   );
 }


 Widget buildSoundGrid(List<Map<String, dynamic>> sounds) {
   return GridView.count(
     crossAxisCount: 2,
     crossAxisSpacing: 16,
     mainAxisSpacing: 16,
     children: sounds
         .map((sound) => buildSoundCard(sound["icon"], sound["title"], sound["file"]))
         .toList(),
   );
 }


 @override
 void dispose() {
   _player.dispose();
   _tabController.dispose();
   _countdownTimer?.cancel();
   super.dispose();
 }


 @override
Widget build(BuildContext context) {
  // ☁️ CLOUD-LIKE GRADIENT BACKGROUND (soft, pastel flow)
  final bgGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: const [
        Color(0xFFB3E5FC),
        Color(0xFFE1F5FE),
        Color(0xFFF0F4FF),
        Color(0xFFFFFFFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          _player.stop();       // stop any playing sound
          _countdownTimer?.cancel(); // cancel the timer
          Navigator.pop(context);
        },

      ),
      title: const Text(
        "Soothing Sounds",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    ),
    body: Container(
      decoration: bgGradient,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Relax, breathe, and let the sounds calm your mind",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: Colors.teal,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Nature"),
                  Tab(text: "Instrumental"),
                  Tab(text: "Meditation"),
                  Tab(text: "Liked"),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildSoundGrid(natureSounds),
                    buildSoundGrid(instrumentalSounds),
                    buildSoundGrid(meditationSounds),
                    likedSounds.isEmpty
                        ? const Center(
                            child: Text("Your liked sounds will appear here 💖"),
                          )
                        : buildSoundGrid([
                            ...natureSounds,
                            ...instrumentalSounds,
                            ...meditationSounds
                          ].where((s) => likedSounds.contains(s["file"])).toList()),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_isPlaying) {
                        _player.pause();
                        _pauseCountdown();
                        setState(() => _isPlaying = false);
                      } else if (_currentSound.isNotEmpty) {
                        _player.resume();
                        _resumeCountdown();
                        setState(() => _isPlaying = true);
                      }
                    },
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 42,
                      color: Colors.teal,
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _timerValue,
                      min: 5,
                      max: 60,
                      divisions: 11,
                      label: "${_timerValue.toInt()} min",
                      onChanged: (val) {
                        setState(() {
                          _timerValue = val;
                          if (_isPlaying) {
                            _remainingTime = Duration(minutes: val.toInt());
                          }
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ),
                  Text(
                    formatDuration(_remainingTime),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}