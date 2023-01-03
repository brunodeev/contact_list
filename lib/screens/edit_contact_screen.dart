// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  const EditContact({required this.name, required this.number, super.key});

  final String name, number;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  TextEditingController nameEdit = TextEditingController();

  TextEditingController numberEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        centerTitle: true,
        title: const Text('Editar'),
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
                  child: Text(
                    widget.name.substring(0, 1),
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: nameEdit,
              decoration: InputDecoration(
                labelText: widget.name,
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
              controller: numberEdit,
              decoration: InputDecoration(
                labelText: widget.number,
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
                  if (nameEdit.text.isEmpty) {
                    updateContactNoName(
                        name: widget.name, number: numberEdit.text);
                    Navigator.of(context).pop();
                  } else if (numberEdit.text.isEmpty) {
                    addContact(name: nameEdit.text, number: widget.number);
                    deleteContact(name: widget.name);
                    Navigator.of(context).pop();
                  } else if (nameEdit.text.isEmpty && numberEdit.text.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    addContact(name: nameEdit.text, number: numberEdit.text);
                    deleteContact(name: widget.name);
                    Navigator.of(context).pop();
                  }
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

Future updateContact(
    {required String name,
    required String number,
    required String nameEdited}) async {
  final String nameP = name.toLowerCase();
  final docUser = FirebaseFirestore.instance.collection('contacts').doc(nameP);

  final json = {
    'name': nameEdited,
    'number': number,
  };

  await docUser.update(json);
}

Future updateContactNoName(
    {required String name, required String number}) async {
  final String nameP = name.toLowerCase();
  final docUser = FirebaseFirestore.instance.collection('contacts').doc(nameP);

  final json = {
    'number': number,
  };

  await docUser.update(json);
}

Future updateContactNoNumber(
    {required String name,
    required String number,
    required String nameEdited}) async {
  final String nameP = name.toLowerCase();
  final docUser = FirebaseFirestore.instance.collection('contacts').doc(nameP);

  final json = {
    'name': nameEdited,
  };

  await docUser.update(json);
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

Future deleteContact({required String name}) async {
  final String nameP = name.toLowerCase();
  final docUser = FirebaseFirestore.instance.collection('contacts').doc(nameP);

  await docUser.delete();
}
