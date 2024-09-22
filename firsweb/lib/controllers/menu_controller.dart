import 'package:firsweb/constants/style.dart';
import 'package:firsweb/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMenuController extends GetxController {
  static MyMenuController instance = Get.find();
  var activeItem = OverViewPageRoute.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String ItemName) {
    if (!isActive(ItemName)) hoverItem.value = ItemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget retunIconFor(String itemName) {
    switch (itemName) {
      case OverViewPageRoute:
        return _customIcon(Icons.analytics, itemName);
      case TransfersPageRoute:
        return _customIcon(Icons.compare_arrows_rounded, itemName);
      case ATMPageRoute:
        return _customIcon(Icons.currency_exchange, itemName);
      case AccountInformationPageRoute:
        return _customIcon(Icons.person, itemName);
      case AuthenticationPageRoute:
        return _customIcon(Icons.logout, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
