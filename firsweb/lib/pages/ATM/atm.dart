import 'package:firebase_auth/firebase_auth.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ATMPage extends StatefulWidget {
  @override
  _ATMPageState createState() => _ATMPageState();
}

class _ATMPageState extends State<ATMPage> {
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
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
          text: 'ATM Transactions',
          size: 26,
          color: dark,
          weight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Amount',
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
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    depositMoney();
                  },
                  child: CustomText(
                    text: 'Deposit',
                    size: 14,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    withdrawMoney();
                  },
                  child: CustomText(
                    text: 'Withdraw',
                    size: 14,
                    color: dark,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void depositMoney() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('UserData');
      users
          .where('email', isEqualTo: currentUser.email)
          .get()
          .then((senderSnapshot) {
        if (senderSnapshot.docs.isNotEmpty) {
          var senderDoc = senderSnapshot.docs[0];
          double currentBalance =
              (senderDoc.data() as Map<String, dynamic>)['balance'] ?? 0.0;
          double newBalance = currentBalance + amount;
          senderDoc.reference.update({'balance': newBalance});
          _showSuccessDialogDeposit('Deposit', amount);
        } else {
          _showErrorDialog('User not found');
        }
      }).catchError((error) {
        _showErrorDialog('Error fetching user: $error');
      });
    }
  }

  void withdrawMoney() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('UserData');
      users
          .where('email', isEqualTo: currentUser.email)
          .get()
          .then((senderSnapshot) {
        if (senderSnapshot.docs.isNotEmpty) {
          var senderDoc = senderSnapshot.docs[0];
          double currentBalance =
              (senderDoc.data() as Map<String, dynamic>)['balance'] ?? 0.0;
          if (currentBalance >= amount) {
            double newBalance = currentBalance - amount;
            senderDoc.reference.update({'balance': newBalance});
            _showSuccessDialogWithdraw('Withdraw', amount);
          } else {
            _showErrorDialog('Insufficient balance');
          }
        } else {
          _showErrorDialog('User not found');
        }
      }).catchError((error) {
        _showErrorDialog('Error fetching user: $error');
      });
    }
  }

  void _showSuccessDialogWithdraw(String action, double amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content:
              Text('$action successful. $amount Withdrawn from your account.'),
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
    _amountController.clear();
  }

  void _showSuccessDialogDeposit(String action, double amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content:
              Text('$action successful. $amount Deposited into your account.'),
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
    _amountController.clear();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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
    _amountController.clear();
  }
}
