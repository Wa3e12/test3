import 'package:firsweb/constants/controllers.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/helpers/responsiveness.dart';
import 'package:firsweb/pages/authentication/authentication.dart';
import 'package:firsweb/routing/routes.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:firsweb/widgets/side_menu_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
        color: light,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: _width / 48,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Image.network(
                          "https://i.imgur.com/ppVGuop.png",
                          scale: 25,
                        ),
                      ),
                      Flexible(
                          child: CustomText(
                              text: "IDB",
                              size: 20,
                              color: active,
                              weight: FontWeight.bold)),
                      SizedBox(
                        width: _width / 48,
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(
              height: 40,
            ),
            Divider(
              color: lightGrey.withOpacity(.1),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItems(
                        itemName: itemName == AuthenticationPageRoute
                            ? "Log Out"
                            : itemName,
                        onTap: () {
                          if (itemName == AuthenticationPageRoute) {
                            Get.offAll(() => AuthenticationPage());
                          }
                          if (!menuController.isActive(itemName)) {
                            menuController.changeActiveItemTo(itemName);
                            if (ResponsiveWidget.isSmallScreen(context))
                              Get.back();
                            navigationController.navigateTo(itemName);
                          }
                        },
                      ))
                  .toList(),
            ),
          ],
        ));
  }
}
