import 'package:flutter/material.dart';


class AboutMentalPage extends StatelessWidget {
 const AboutMentalPage({super.key});


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
       appBar: AppBar(title: const Text('About Mental Health'), backgroundColor: bgStart, elevation: 0),
       body: ListView(
         padding: const EdgeInsets.all(16),
         children: [
           ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/images/mental_health.png', fit: BoxFit.cover)),
           const SizedBox(height: 16),
           _Section(title: 'What is Mental Health?', text: 'Mental health is emotional, psychological and social well-being — it affects thoughts, feelings and actions. It is the presence of resilience, not only the absence of illness.', bg: white95, shadowColor: shadow),
           _Section(title: 'Why It Matters', text: 'Good mental health supports relationships, productivity, physical health and life satisfaction.', bg: white95, shadowColor: shadow),
           _Section(title: 'Small Daily Habits', text: '• Prioritise sleep\n• Move your body\n• Take short digital breaks\n• Eat nourishing food\n• Talk to someone you trust', bg: white95, shadowColor: shadow),
           _Section(title: 'Invisible Backpack', text: 'Imagine carrying an invisible backpack of stresses and feelings. Mental health is learning to check the load and ask for help when it gets heavy.', bg: white95, shadowColor: shadow),
           _Section(title: 'Takeaway', text: 'This week: choose one area (sleep, screen time, food, or relationships) and try one small change.', italic: true, bg: white95, shadowColor: shadow),
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
