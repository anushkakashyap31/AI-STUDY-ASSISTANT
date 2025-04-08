import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/chatbot_screen.dart';
import 'planner/planner_screen.dart';  
import 'screens/progress_tracker_screen.dart';
import 'quizzes/quiz_list_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/recommendation_screen.dart';
import 'screens/rewards_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Study Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/planner': (context) => PlannerScreen(), 
        '/progress': (context) => const ProgressTrackerScreen(),
        '/quizzes': (context) => const QuizListScreen(),
        '/notes': (context) => const NotesScreen(),
        '/flashcards': (context) => const FlashcardScreen(),
        '/recommendations': (context) => const RecommendationScreen(),
        '/rewards': (context) => const RewardsScreen(),
      },
    );
  }
}
