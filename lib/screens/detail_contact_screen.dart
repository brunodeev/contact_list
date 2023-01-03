// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/screens/edit_contact_screen.dart';
import 'package:flutter/material.dart';

class DetailContact extends StatelessWidget {
  const DetailContact({required this.name, required this.number, super.key});

  final String name, number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        centerTitle: true,
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: CircleAvatar(
                    backgroundColor: const Color(0xFF616161),
                    radius: 50,
                    child: Text(
                      name.substring(0, 1),
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 30, color: Colors.grey[800]),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  style: TextStyle(fontSize: 30, color: Colors.grey[800]),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 52, 109, 194),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditContact(
                            name: name,
                            number: number,
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Editar'),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 204, 58, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      deleteContact(name: name);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future deleteContact({required String name}) async {
  final String nameP = name.toLowerCase();
  final docUser = FirebaseFirestore.instance.collection('contacts').doc(nameP);

  await docUser.delete();
}
