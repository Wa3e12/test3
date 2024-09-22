import 'package:cloud_firestore/cloud_firestore.dart';

class DatabassService {
  final String uid;

  DatabassService({required this.uid});

  final _db = FirebaseFirestore.instance;

  Future updateUserData(double balance, String ID, String email) async {
    try {
      await _db
          .collection('UserData')
          .doc(uid)
          .set({"balance": balance, "ID": ID, "UserID": uid, "email": email});
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> get userData {
    return _db.collection('UserData').snapshots();
  }
}
