import 'package:firebasecrud/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Initializes the firebase services example firestore, authentication , cloud messaging ..
    options: DefaultFirebaseOptions.currentPlatform,
    // specify the default options for firebase initialization based on the current platform ( ANDROID AND IOS)
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}