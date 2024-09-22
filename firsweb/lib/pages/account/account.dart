import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/database/get_user_balance.dart';
import 'package:firsweb/database/get_user_info.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firsweb/database/database.dart';
import 'package:path_provider/path_provider.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
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
                    height: 600,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 167, 167, 167),
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      color: light,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetUserInfo(documentId: data[0]),
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
