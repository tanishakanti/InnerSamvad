// lib/knowledgepages/stresspage.dart
import 'package:flutter/material.dart';


class StressPage extends StatelessWidget {
 const StressPage({super.key});


 @override
 Widget build(BuildContext context) {
   const Color bgStart = Color.fromARGB(255, 175, 215, 240);
   const Color bgEnd = Color.fromARGB(255, 234, 240, 246);


   final Color white95 = const Color.fromRGBO(255, 255, 255, 0.95);
   final Color shadow = const Color.fromRGBO(96, 125, 139, 0.12);


   return Container(
     decoration: const BoxDecoration(gradient: LinearGradient(colors: [bgStart, bgEnd], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
     child: Scaffold(
       backgroundColor: Colors.transparent,
       appBar: AppBar(title: const Text('Stress'), backgroundColor: bgStart, elevation: 0),
       body: ListView(
         padding: const EdgeInsets.all(16),
         children: [
           ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/images/stress.png', fit: BoxFit.cover)),
           const SizedBox(height: 16),
           _Section(title: 'Understanding Stress', text: 'Stress is the body and mind’s response to demands. Short-term stress can focus attention; chronic stress can harm physical and mental health.', bg: white95, shadowColor: shadow),
           _Section(title: 'Signs', text: '• Headaches, fatigue\n• Irritability, racing thoughts\n• Sleep disturbances, appetite change', bg: white95, shadowColor: shadow),
           _Section(title: 'Types', text: 'Acute (short), Episodic (frequent), Chronic (ongoing) — each needs different coping strategies.', bg: white95, shadowColor: shadow),
           _Section(title: 'Mindful Pause', text: 'Close your eyes for 1–2 minutes. Notice breath and soften shoulders. Repeat 3 times.', bg: white95, shadowColor: shadow),
           _Section(title: 'Takeaway', text: '“Stress is a signal — notice it, understand it, and use strategies to release it.”', italic: true, bg: white95, shadowColor: shadow),
           Card(
             color: white95,
             elevation: 3,
             shadowColor: shadow,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
             margin: const EdgeInsets.only(top: 12),
             child: Padding(
               padding: const EdgeInsets.all(14),
               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                 Text('Interactive Activity: Stress Ball Toss', style: TextStyle(fontWeight: FontWeight.bold)),
                 SizedBox(height: 8),
                 Text('Use a soft ball in a small group. Toss the ball, name one stressor, and brainstorm small solutions.'),
               ]),
             ),
           ),
         ],
       ),
     ),
   );
 }
}


class _Section extends StatelessWidget {
 final String title, text;
 final bool italic;
 final Color bg;
 final Color shadowColor;
 const _Section({required this.title, required this.text, this.italic = false, required this.bg, required this.shadowColor});


 @override
 Widget build(BuildContext context) {
   return Card(
     color: bg,
     elevation: 3,
     shadowColor: shadowColor,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
     margin: const EdgeInsets.only(bottom: 12),
     child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
       const SizedBox(height: 8),
       Text(text, style: TextStyle(fontSize: 14, height: 1.4, fontStyle: italic ? FontStyle.italic : FontStyle.normal)),
     ])),
   );
 }
}
