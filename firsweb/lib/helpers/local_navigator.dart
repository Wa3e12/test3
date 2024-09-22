import 'package:firsweb/constants/controllers.dart';
import 'package:firsweb/routing/router.dart';
import 'package:firsweb/routing/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: OverViewPageRoute,
      onGenerateRoute: generateRoute,
    );
