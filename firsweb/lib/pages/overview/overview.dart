import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/database/get_user_balance.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firsweb/database/database.dart';
import 'package:path_provider/path_provider.dart';

class OverViewPage extends StatefulWidget {
  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  List<String> data = [];
  User? user = FirebaseAuth.instance.currentUser;

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            data.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getData(),
              initialData: [],
              builder: (context, snapshot) {
                return InkWell(
                  child: Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Signed in as: ${user!.email.toString().split("@").first}',
                            style: TextStyle(
                              color: light,
                              fontSize: 20,
                            ),
                          ),
                          GetUserBalance(documentId: data[0]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
