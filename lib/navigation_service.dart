import 'package:flutter/material.dart';

class NavigationService {
 late GlobalKey<NavigatorState> key;

  static NavigationService instance = NavigationService();
 static NavigationService adminInstance = NavigationService();
 static NavigationService userInstance = NavigationService();



  NavigationService() {
    key = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _rn) {
    return key.currentState!.pushReplacementNamed(_rn);
  }

  Future<dynamic> navigateTo(String _rn) {
    return key.currentState!.pushNamed(_rn);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return key.currentState!.push(_rn);
  }

  Future<dynamic> navigateToWidget(Widget _rn) {
    return key.currentState!.push(MaterialPageRoute(builder: (_) => _rn));
  }

  goBack() {
    return key.currentState!.pop();
  }

  void pushReplacement(String newRouteName) {
    bool isNewRouteSameAsCurrent = false;

    key.currentState!.popUntil((route) {
      if (route.settings.name == newRouteName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });
    if (!isNewRouteSameAsCurrent) {
      key.currentState!.pushNamedAndRemoveUntil(newRouteName, (Route<dynamic> route) => false);
    }
  }
}
