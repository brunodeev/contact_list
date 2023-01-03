import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({super.key});

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
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
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF616161),
                  radius: 50,
                  child: name.text.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.white,
                        )
                      : Text(
                          name.text.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ),
                ),
              ),
            ),
            TextField(
              onChanged: (name) {
                setState(() {
                  name = name;
                });
              },
              keyboardType: TextInputType.text,
              controller: name,
              decoration: InputDecoration(
                labelText: 'Nome',
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xFF212121),
                    width: 3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: number,
              decoration: InputDecoration(
                labelText: 'Número',
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xFF212121),
                    width: 3,
                  ),
                ),
              ),
            ),
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
