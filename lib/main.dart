import 'package:contact_app/screens/create_contact_screen.dart';
import 'package:contact_app/screens/detail_contact_screen.dart';
import 'package:contact_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Erro');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/createContact': (context) => CreateContact(),
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.grey[900],
          ),
        );
        ;
      },
    );
  }
}
