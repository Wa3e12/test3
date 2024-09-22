import 'package:firsweb/constants/style.dart';
import 'package:firsweb/helpers/responsiveness.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Image.network(
                    "https://i.imgur.com/ppVGuop.png",
                    width: 34,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
              child: CustomText(
                  text: "IDB",
                  size: 20,
                  color: lightGrey,
                  weight: FontWeight.bold)),
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(
                color: active, borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: light,
                child: Icon(
                  Icons.person_outline,
                  color: dark,
                ),
              ),
            ),
          )
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: light,
    );
