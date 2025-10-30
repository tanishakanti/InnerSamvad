// lib/knowledgepages/anxietypage.dart
import 'package:flutter/material.dart';


class AnxietyPage extends StatelessWidget {
 const AnxietyPage({super.key});


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
       appBar: AppBar(title: const Text('Anxiety'), backgroundColor: bgStart, elevation: 0),
       body: ListView(
         padding: const EdgeInsets.all(16),
         children: [
           ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/images/anxiety.png', fit: BoxFit.cover)),
           const SizedBox(height: 16),
           _Card(title: 'Overview', text: 'Anxiety is the mind’s alarm system — helpful in danger, overwhelming when stuck “on.” It can feel like racing thoughts, tight chest, or fear without reason.', bg: white95, shadowColor: shadow),
           _Card(title: 'How It Feels', text: '• Physical: racing heartbeat, sweaty palms, tense muscles\n• Emotional: worry, irritability\n• Mental: repetitive thoughts, difficulty focusing', bg: white95, shadowColor: shadow),
           _Card(title: 'Common Types', text: 'GAD (Generalized Anxiety Disorder), Social Anxiety, Panic Disorder, Phobias — each has different triggers and treatments.', bg: white95, shadowColor: shadow),
           _Card(title: 'Grounding Tools', text: '• 4-4-4 Breathing\n• 5-4-3-2-1 grounding\n• Journaling to externalize worries\n• Reduce caffeine and prioritise sleep', bg: white95, shadowColor: shadow),
           _Card(title: 'When To Seek Help', text: 'If anxiety limits daily life, causes panic attacks or severe sleep disturbance — consider professional support. Therapies like CBT are effective.', bg: white95, shadowColor: shadow),
           _Card(title: 'Takeaway', text: '“Anxiety is a signal, not a limit — face it, seek support and thrive.”', italic: true, bg: white95, shadowColor: shadow),
         ],
       ),
     ),
   );
 }
}


class _Card extends StatelessWidget {
 final String title, text;
 final bool italic;
 final Color bg;
 final Color shadowColor;
 const _Card({required this.title, required this.text, this.italic = false, required this.bg, required this.shadowColor});


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
