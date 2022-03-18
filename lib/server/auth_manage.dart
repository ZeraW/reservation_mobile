import 'package:flutter/material.dart';

import '../views/sign/sign_in_screen.dart';
import '../views/sign/sign_up_screen.dart';



class AuthManage extends ChangeNotifier {
  int? pageState = 0;

  void toggleWidgets({int? currentPage}) {
    pageState = currentPage;
    notifyListeners();
  }

  void onBackPressed() {
    if (pageState == 0) {

    } else {
      pageState = 0;
      notifyListeners();
    }
  }

  Widget currentWidget() {
    if (pageState == 0) {
      return const SignInScreen();
    } else {
      return const SignUpScreen();
    }
  }
}
