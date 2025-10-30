import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inner_samvad/appointmentBooking/appointmentBookScreen.dart';
import 'package:inner_samvad/homePage.dart';
import 'package:inner_samvad/knowledgeHub/knowledgehub.dart';
import 'package:inner_samvad/soundLibrary/soothingpage.dart';
import 'package:inner_samvad/startPage.dart';
import 'package:inner_samvad/login_screen.dart';
import 'package:inner_samvad/signUp_Screen.dart';
import 'firebase_options.dart';
import 'crisisButton/crisisButtonScreen.dart';
import 'questionaire/questionaire_home.dart';
import 'snake_ladder/snake_ladder_game.dart';
import 'package:inner_samvad/moodTracker/moodpage.dart';
import 'package:inner_samvad/setting.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/start',
  routes: {
    '/start': (context) => StartPage(),
    '/signup': (context) => SignUpScreen(),
    '/login': (context) => LoginScreen(),
    '/homePage': (context) => const HomePage(),
    '/appointmentBookScreen': (context) => const AppointmentForm(),
    '/crisisButton': (context) => const CrisisButtonScreen(),
    '/questionaire': (context) => const QuestionnaireHome(),
    '/soothingPage': (context) => const SoothingSoundsPage(),
    '/knowledgeHub': (context) => const KnowledgeHubScreen(),
    '/snakeandladder': (context) => const BoardScreen(),
    '/moodTracker': (context) => const MoodTrackerScreen(),
    '/settingPage': (context) => const SettingsScreen(),
  },
));
}
