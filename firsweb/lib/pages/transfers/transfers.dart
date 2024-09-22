import 'package:firebase_auth/firebase_auth.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransfersPage extends StatefulWidget {
  @override
  _TransfersPageState createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  TextEditingController _recipientEmailController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _recipientEmailController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: light,
        automaticallyImplyLeading: false,
        title: CustomText(
            text: 'Bank Transaction',
            size: 26,
            color: dark,
            weight: FontWeight.bold),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recipient ID',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _recipientEmailController,
              decoration: InputDecoration(
                hintText: 'Enter recipient\'s ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount to send',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                transferMoney();
              },
              child: CustomText(
                  text: 'Confirm',
                  size: 14,
                  color: dark,
                  weight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void transferMoney() {
    String recipientEmail = _recipientEmailController.text + '@example.com';
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    User? CurrUser = FirebaseAuth.instance.currentUser;
    // fetch sender document based on email/id
    users
        .where('email', isEqualTo: CurrUser?.email)
        .get()
        .then((senderSnapshot) {
      if (senderSnapshot.docs.isNotEmpty) {
        var senderDoc = senderSnapshot.docs[0];

        // get sender balance
        double senderBalance =
            (senderDoc.data() as Map<String, dynamic>)['balance'] ?? 0.0;

        // Fetch recipient's document based on email/id
        users
            .where('email', isEqualTo: recipientEmail)
            .get()
            .then((recipientSnapshot) {
          if (recipientSnapshot.docs.isNotEmpty) {
            var recipientDoc = recipientSnapshot.docs[0];

            // get recipient balance
            double recipientBalance =
                (recipientDoc.data() as Map<String, dynamic>)['balance'] ?? 0.0;

            if (senderBalance >= amount) {
              // calculate new balances
              double newSenderBalance = senderBalance - amount;
              double newRecipientBalance = recipientBalance + amount;

              // update sender's balance
              senderDoc.reference.update({'balance': newSenderBalance});

              // update recipient balance
              recipientDoc.reference.update({'balance': newRecipientBalance});

              print(
                  'Transaction successful. $amount transferred to $recipientEmail');
              _recipientEmailController.clear();
              _amountController.clear();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text(
                        'Transaction successful. $amount transferred to ' +
                            recipientEmail.split("@").first),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              print('Insufficient balance');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Failed'),
                    content: Text('Insufficient balance'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            print('Recipient not found');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Failed'),
                  content: Text('Recipient not found'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        }).catchError((error) {
          print('Error fetching recipient: $error');
        });
      } else {
        print('Sender not found');
      }
    }).catchError((error) {
      print('Error fetching sender: $error');
    });
  }
}
