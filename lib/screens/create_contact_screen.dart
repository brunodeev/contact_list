import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/models/text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateContact extends StatelessWidget {
  CreateContact({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        centerTitle: true,
        title: const Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xFF616161),
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            kTextField('Nome', name, TextInputType.text),
            const SizedBox(
              height: 15,
            ),
            kTextField('Número', number, TextInputType.phone),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 39, 39, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  addContact(name: name.text, number: number.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future addContact({required String name, required String number}) async {
  final docUser =
      FirebaseFirestore.instance.collection('contacts').doc(name.toLowerCase());

  final json = {
    'id': Random().nextInt(10000),
    'name': name,
    'number': number,
  };

  await docUser.set(json);
}
