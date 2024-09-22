import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firsweb/constants/style.dart';
import 'package:flutter/material.dart';

class GetUserBalance extends StatelessWidget {
  final String documentId;

  GetUserBalance({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            'Current Balance: \$${data['balance']}',
            style: TextStyle(color: light, fontSize: 33),
          );
        }
        return Text(
          'Loading...',
          style: TextStyle(color: light, fontSize: 35),
        );
      },
    );
  }
}
