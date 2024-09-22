import 'package:firsweb/helpers/responsiveness.dart';
import 'package:firsweb/widgets/large_screen.dart';
import 'package:firsweb/widgets/side_menu.dart';
import 'package:firsweb/widgets/small_screen.dart';
import 'package:firsweb/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: topNavigationBar(context, scaffoldkey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
