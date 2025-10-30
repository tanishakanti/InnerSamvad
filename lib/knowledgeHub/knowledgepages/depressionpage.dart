import 'package:flutter/material.dart';


class DepressionPage extends StatelessWidget {
 const DepressionPage({super.key});


 @override
 Widget build(BuildContext context) {
   const Color bgStart = Color.fromARGB(255, 175, 215, 240);
   const Color bgEnd = Color.fromARGB(255, 234, 240, 246);


   final Color white95 = const Color.fromRGBO(255, 255, 255, 0.95);
   final Color shadow = const Color.fromRGBO(96, 125, 139, 0.12);


   return Container(
     decoration: const BoxDecoration(
       gradient: LinearGradient(
         colors: [bgStart, bgEnd],
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
       ),
     ),
     child: Scaffold(
       backgroundColor: Colors.transparent,
       appBar: AppBar(
         title: const Text('Depression'),
         backgroundColor: bgStart,
         elevation: 0,
       ),
       body: ListView(
         padding: const EdgeInsets.all(16),
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(14),
             child: Image.asset('assets/images/depression.png', fit: BoxFit.cover),
           ),
           const SizedBox(height: 16),


           _Card(
             title: 'What Exactly Is Depression?',
             text:
             'Everyone has sad days after exams, fights, or failures. That sadness usually fades with rest or music. Depression is different — it’s when low mood, emptiness, or loss of interest lasts for two weeks or more and starts to disturb daily life. '
                 '\n\nImagine carrying a backpack. At first, it’s light. But as more “stones” like stress, heartbreak, and pressure are added, it becomes too heavy — that’s what depression often feels like: an invisible weight pulling you down.'
                 '\n\nWHO reports that over 280 million people live with depression — in a class of 40, at least 2–3 students may be struggling.',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Signs & Symptoms',
             text:
             '• Persistent sadness or emptiness\n'
                 '• Loss of interest in things you loved\n'
                 '• Fatigue or low energy\n'
                 '• Trouble concentrating\n'
                 '• Changes in sleep or appetite\n'
                 '• Irritability or unexplained anger\n'
                 '• Thoughts of hopelessness',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Types of Depression',
             text:
             '• Major Depression – strong sadness and loss of interest lasting weeks or months.\n'
                 '• Persistent Depression (Dysthymia) – dull sadness lasting 2+ years; life feels “half-empty.”\n'
                 '• Bipolar Depression – alternating low moods and periods of extreme energy.\n'
                 '• Seasonal Affective Disorder (SAD) – mood dips in specific seasons (often winter or monsoon).\n'
                 '• Postpartum Depression – occurs after childbirth due to hormonal and emotional changes.\n'
                 '• PMDD – severe mood and energy drop before menstruation.\n\nEach type shows that depression is not one-size-fits-all.',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Myths & Facts',
             text:
             'Myth: It’s just laziness.\n'
                 'Fact: Depression is a medical condition.\n\n'
                 'Myth: “Snap out of it” works.\n'
                 'Fact: It requires treatment and support.',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Quick Self-Check',
             text:
             'Ask yourself:\n'
                 '• Have I felt low for 2+ weeks?\n'
                 '• Do I avoid things I used to enjoy?\n'
                 '• Has my sleep, appetite, or energy changed?\n'
                 '• Do I feel worthless or hopeless?\n\n'
                 'If you answered “Yes” to 3 or more, please consider professional support. (Psychometric test: PHQ-9)',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Self-Coping Strategies',
             text:
             '💡 The 1-1-1 Practice:\n'
                 '• Do 1 thing for your body (walk, stretch, hydrate)\n'
                 '• Do 1 thing for your mind (read, write, breathe deeply)\n'
                 '• Do 1 thing for connection (call or message someone you trust)\n\n'
                 'Interactive Activity — “Energy Jar”:\n'
                 'Every evening, write down one small thing that gave you energy — a smile, a song, a meme. '
                 'Over time, these moments remind you that joy still exists even on tough days.',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Counselling & Support',
             text:
             'Counselling isn’t weakness — it’s about creating a safe, confidential space to understand your emotions and strengthen coping skills.\n\n'
                 'It improves focus, reduces stress, and builds resilience. '
                 'Medication may be prescribed for severe depression — just like treating fever or diabetes, it balances brain chemicals to aid healing.\n\n'
                 'Lifestyle Support:\n• Regular sleep\n• Balanced meals\n• Mindful breaks\n\nThink of it as a system:\nCounselling + (sometimes) Medication + Healthy Habits = Stronger You.',
             bg: white95,
             shadowColor: shadow,
           ),


           _Card(
             title: 'Takeaway',
             text:
             '“You are more than your bad days. Depression is real, but recovery is possible — and support is closer than you think.”\n\n— Asma Akbar Shaikh',
             italic: true,
             bg: white95,
             shadowColor: shadow,
           ),
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
 const _Card({
   required this.title,
   required this.text,
   this.italic = false,
   required this.bg,
   required this.shadowColor,
 });


 @override
 Widget build(BuildContext context) {
   return Card(
     color: bg,
     elevation: 3,
     shadowColor: shadowColor,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
     margin: const EdgeInsets.only(bottom: 12),
     child: Padding(
       padding: const EdgeInsets.all(14),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
           const SizedBox(height: 8),
           Text(
             text,
             style: TextStyle(
               fontSize: 14,
               height: 1.4,
               fontStyle: italic ? FontStyle.italic : FontStyle.normal,
             ),
           ),
         ],
       ),
     ),
   );
 }
}
