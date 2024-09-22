import 'dart:ui';

import 'package:firsweb/constants/controllers.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HorizontalMenuItems extends StatelessWidget {
  final String itemName;
  final void Function()? onTap;

  const HorizontalMenuItems(
      {super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? lightGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  child: Container(
                    width: 6,
                    height: 40,
                    color: dark,
                  ),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                ),
                SizedBox(
                  width: _width / 80,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: menuController.retunIconFor(itemName),
                ),
                if (!menuController.isActive(itemName))
                  Flexible(
                      child: CustomText(
                          text: itemName,
                          size: 16,
                          color: menuController.isHovering(itemName)
                              ? dark
                              : lightGrey,
                          weight: FontWeight.normal))
                else
                  Flexible(
                      child: CustomText(
                          text: itemName,
                          size: 18,
                          color: dark,
                          weight: FontWeight.bold))
              ],
            ),
          )),
    );
  }
}
