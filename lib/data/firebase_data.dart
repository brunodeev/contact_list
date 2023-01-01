import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getList() {
  return FirebaseFirestore.instance.collection('contacts').snapshots();
}
