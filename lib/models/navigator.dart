import 'package:flutter/material.dart';

class NavigatorModel with ChangeNotifier {
  String currentRoute = "login";

  void changeRoute(String route) {
    this.currentRoute = route;
    notifyListeners();
  }

}
