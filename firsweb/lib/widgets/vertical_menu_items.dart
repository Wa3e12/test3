import 'package:firsweb/constants/controllers.dart';
import 'package:firsweb/constants/style.dart';
import 'package:firsweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerticalMenuItems extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const VerticalMenuItems(
      {super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                    width: 3,
                    height: 72,
                    color: dark,
                  ),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: menuController.retunIconFor(itemName),
                    ),
                    if (!menuController.isActive(itemName))
                      Flexible(
                          child: CustomText(
                              text: itemName,
                              size: 18,
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
                ))
              ],
            ),
          )),
    );
  }
}
