// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/screens/edit_contact_screen.dart';
import 'package:flutter/material.dart';

class DetailContact extends StatefulWidget {
  const DetailContact({required this.name, required this.number, super.key});

  final String name, number;

  @override
  State<DetailContact> createState() => _DetailContactState();
}

class _DetailContactState extends State<DetailContact> {
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
                      widget.name.substring(0, 1),
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
                  widget.name,
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
                  widget.number,
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
                            name: widget.name,
                            number: widget.number,
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
                    onPressed: () async {
                      bool isDelete = false;

                      await showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              title: const Text('Excluir Contato'),
                              content: const Text(
                                  'Tem certeza que deseja excluir este contato?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isDelete = false;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isDelete = true;
                                    });
                                    deleteContact(context, name: widget.name);
                                  },
                                  child: const Text(
                                    'Excluir',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              ],
                            );
                          });

                      isDelete == true
                          ? deleteContact(context, name: widget.name)
                          : null;
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

Future deleteContact(BuildContext context, {required String name}) async {
  final String nameP = name.toLowerCase();
  final docUser = FirebaseFirestore.instance.collection('contacts').doc(nameP);

  await docUser.delete();
  Navigator.pop(context);
}

deletecont(BuildContext context, bool delete) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Contato'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Excluir'),
            ),
          ],
        );
      });
}

changeDelete(bool del) {
  del = !del;
}
