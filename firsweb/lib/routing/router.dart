import 'package:firsweb/pages/ATM/atm.dart';
import 'package:firsweb/pages/account/account.dart';
import 'package:firsweb/pages/authentication/authentication.dart';
import 'package:firsweb/pages/overview/overview.dart';
import 'package:firsweb/pages/transfers/transfers.dart';
import 'package:firsweb/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OverViewPageRoute:
      return _getPageRoute(OverViewPage());
    case TransfersPageRoute:
      return _getPageRoute(TransfersPage());
    case ATMPageRoute:
      return _getPageRoute(ATMPage());
    case AccountInformationPageRoute:
      return _getPageRoute(AccountPage());
    default:
      return _getPageRoute(OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
