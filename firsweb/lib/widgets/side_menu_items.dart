import 'package:firsweb/helpers/responsiveness.dart';
import 'package:firsweb/widgets/horizontal_menu_items.dart';
import 'package:firsweb/widgets/vertical_menu_items.dart';
import 'package:flutter/material.dart';

class SideMenuItems extends StatelessWidget {
  final String itemName;
  final void Function() onTap;

  const SideMenuItems({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context))
      return VerticalMenuItems(itemName: itemName, onTap: onTap);

    return HorizontalMenuItems(itemName: itemName, onTap: onTap);
  }
}
