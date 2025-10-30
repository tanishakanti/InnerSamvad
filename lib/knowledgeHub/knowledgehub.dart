import 'package:flutter/material.dart';
import 'knowledgepages/depressionpage.dart';
import 'knowledgepages/anxietypage.dart';
import 'knowledgepages/stresspage.dart';
import 'knowledgepages/aboutmental.dart';




class KnowledgeHubScreen extends StatefulWidget {
 const KnowledgeHubScreen({super.key});


 @override
 State<KnowledgeHubScreen> createState() => _KnowledgeHubScreenState();
}


class _KnowledgeHubScreenState extends State<KnowledgeHubScreen> {
 final TextEditingController _searchCtrl = TextEditingController();
 String _query = '';


 // Colors (use consistent RGB values to avoid withOpacity)
 final Color bgStart = const Color.fromARGB(255, 175, 215, 240);
 final Color bgEnd = const Color.fromARGB(255, 234, 240, 246);
 final Color primaryBlue = const Color(0xFF3B8BEA);


 final List<_Topic> _topics = [
   _Topic(
     title: 'Depression',
     desc:
     'Understand causes, symptoms, and ways to manage or overcome depression.',
     img: 'assets/images/depression.png',
     page: const DepressionPage(),
   ),
   _Topic(
     title: 'Anxiety',
     desc:
     'Learn about anxiety, its triggers, coping mechanisms, and calming techniques.',
     img: 'assets/images/anxiety.png',
     page: const AnxietyPage(),
   ),
   _Topic(
     title: 'Stress',
     desc:
     'Discover how to identify stress and use relaxation strategies to balance your mind.',
     img: 'assets/images/stress.png',
     page: const StressPage(),
   ),
   _Topic(
     title: 'About Mental Health',
     desc:
     'General information and awareness about mental well-being and self-care practices.',
     img: 'assets/images/mental_health.png',
     page: const AboutMentalPage(),
   ),
 ];


 List<_Topic> get filtered => _topics
     .where((t) =>
 t.title.toLowerCase().contains(_query.toLowerCase()) ||
     t.desc.toLowerCase().contains(_query.toLowerCase()))
     .toList();


 @override
 void initState() {
   super.initState();
   _searchCtrl.addListener(() => setState(() => _query = _searchCtrl.text));
 }


 @override
 void dispose() {
   _searchCtrl.dispose();
   super.dispose();
 }


 @override
 Widget build(BuildContext context) {
   // helper colors using RGBO for semi-transparent white / shadows
   final Color semiWhite85 = const Color.fromRGBO(255, 255, 255, 0.85);
   final Color cardShadow = const Color.fromRGBO(0, 0, 0, 0.08);


   return Container(
     decoration: BoxDecoration(
       gradient: LinearGradient(
         colors: [bgStart, bgEnd],
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
       ),
     ),
     child: Scaffold(
       backgroundColor: Colors.transparent, // let gradient show
       appBar: AppBar(
         title: const Text('Knowledge Hub'),
         backgroundColor: bgStart,
         elevation: 0,
         centerTitle: true,
       ),
       body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.all(16),
           child: Column(
             children: [
               // Search bar
               TextField(
                 controller: _searchCtrl,
                 decoration: InputDecoration(
                   hintText: 'Search by topic or feeling...',
                   prefixIcon: const Icon(Icons.search, color: Colors.black54),
                   filled: true,
                   fillColor: semiWhite85,
                   contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(12),
                     borderSide: BorderSide.none,
                   ),
                 ),
               ),
               const SizedBox(height: 20),


               // Insight card (use RGBO for gradient overlay)
               Container(
                 padding: const EdgeInsets.all(18),
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     colors: [
                       const Color.fromRGBO(59, 139, 234, 0.9), // primaryBlue ~ 0xFF3B8BEA
                       bgStart,
                     ],
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                   ),
                   borderRadius: BorderRadius.circular(16),
                   boxShadow: [
                     BoxShadow(
                       color: const Color.fromRGBO(59, 139, 234, 0.28),
                       blurRadius: 8,
                       offset: const Offset(0, 3),
                     ),
                   ],
                 ),
                 child: const Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Today’s Insight', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                     SizedBox(height: 6),
                     Text(
                       '“Your mental health matters. Breathe, rest, and trust the process — you’re doing better than you think.”',
                       style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                     ),
                   ],
                 ),
               ),


               const SizedBox(height: 20),
               Expanded(
                 child: filtered.isEmpty
                     ? const Center(child: Text('No results found.', style: TextStyle(color: Colors.black54)))
                     : ListView.builder(
                   itemCount: filtered.length,
                   itemBuilder: (context, i) {
                     final t = filtered[i];
                     return AnimatedContainer(
                       duration: const Duration(milliseconds: 350),
                       curve: Curves.easeInOut,
                       margin: const EdgeInsets.only(bottom: 14),
                       decoration: BoxDecoration(
                         color: semiWhite85,
                         borderRadius: BorderRadius.circular(14),
                         boxShadow: [BoxShadow(color: cardShadow, blurRadius: 6)],
                       ),
                       child: InkWell(
                         onTap: () {
                           if (t.page != null) {
                             Navigator.push(context, MaterialPageRoute(builder: (_) => t.page!));
                           } else {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Page not added yet.')));
                           }
                         },
                         child: Row(
                           children: [
                             ClipRRect(
                               borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                               child: Image.asset(t.img, height: 110, width: 110, fit: BoxFit.cover),
                             ),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                   Text(t.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                   const SizedBox(height: 6),
                                   Text(t.desc, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                                 ]),
                               ),
                             ),
                             const Padding(
                               padding: EdgeInsets.only(right: 12),
                               child: Icon(Icons.arrow_forward_ios, color: Colors.black45, size: 16),
                             ),
                           ],
                         ),
                       ),
                     );
                   },
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


class _Topic {
 final String title, desc, img;
 final Widget? page;
 _Topic({required this.title, required this.desc, required this.img, this.page});
}
