import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GetUserInfo extends StatelessWidget {
  final String documentId;
  List<String> params = ['balance', 'ID', 'UserID'];
  List<String> names = ['Balance: \$', 'ID: ', 'UserID: '];

  GetUserInfo({required this.documentId});

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
          return Container(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: light,
                  child: Center(
                      child: CustomText(
                          text: "${names[index]}${data[params[index]]}",
                          size: 28,
                          color: dark,
                          weight: FontWeight.normal)),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
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
