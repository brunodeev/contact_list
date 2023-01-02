import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:contact_app/components/contact_card.dart';

import '../data/firebase_data.dart';
import '../navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text('Contatos'),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: getList(),
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[900],
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      FirebaseFirestore.instance.collection('contacts').get();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return index == 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ContactCard(
                                  doc['name'],
                                  doc['number'],
                                ),
                              )
                            : ContactCard(
                                doc['name'],
                                doc['number'],
                              );
                      },
                    ),
                  );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                onPressed: () => {
                  createContact(context),
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
