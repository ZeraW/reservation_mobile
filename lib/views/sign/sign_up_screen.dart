import 'package:flutter/material.dart';
import 'components/sign_up_form_widget.dart';


class SignUpScreen extends StatelessWidget {
  static const routeName = 'sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SignUpFormWidget(),
    );
  }
}
