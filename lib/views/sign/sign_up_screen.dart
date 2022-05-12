import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../server/auth_manage.dart';
import 'components/sign_up_form_widget.dart';


class SignUpScreen extends StatelessWidget {
  static const routeName = 'sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthManage>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: IconButton(onPressed: (){
        provider.onBackPressed();
      },icon: const Icon(Icons.arrow_back_sharp),)),
      backgroundColor: Colors.white,
      body: SignUpFormWidget(),
    );
  }
}
