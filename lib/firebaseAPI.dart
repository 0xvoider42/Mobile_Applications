import 'package:cloud_firestore/cloud_firestore.dart';

void addDataToFirebase(data) async {
  CollectionReference calculations = FirebaseFirestore.instance.collection('calculations');
  await calculations.add({'equation': data});
}