import 'package:contact_app/screens/create_contact_screen.dart';
import 'package:contact_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
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
          return Container(
            color: const Color(0xff212121),
            child: const Center(
              child: Text('Erro'),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/createContact': (context) => const CreateContact(),
            },
          );
        }
        return Container(
          color: const Color(0xFF212121),
        );
      },
    );
  }
}
