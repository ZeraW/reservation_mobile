import 'package:flutter/material.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/utils/dimensions.dart';
import 'components/sign_in_form_widget.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = 'sign_in_screen';

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SignInFormWidget(),
    );
  }
}
