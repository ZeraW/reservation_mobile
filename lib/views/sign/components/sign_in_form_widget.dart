import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import '../../../constants/constants.dart';
import '../../../server/auth.dart';
import '../../../server/auth_manage.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class SignInFormWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();

  SignInFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: Responsive.height(15, context),
            ),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: fontSize25,
                fontWeight: FontWeight.bold,
                color: xColors.black,
              ),
            ),
            const Text(
              'Nice to see you again!',
              style: TextStyle(
                fontSize: fontSize17,
                fontWeight: FontWeight.w500,
                color: xColors.hintColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormBuilder(
              hint: "Email",
              controller: emailTEC,
              validator: (value) {
                if (value!.isEmpty || !isEmail(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormBuilder(
              hint: "Password",
              controller: passwordTEC,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonWidget(
              const Text('Login',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              color: xColors.black,
              isExpanded: true,
              fun: () {
                signIn();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(children: [
              const Text("Don't have account?  ",style: TextStyle(
                fontSize: fontSize17,
                fontWeight: FontWeight.w500,
                color: xColors.hintColor,
              ),),
              GestureDetector(
                onTap: (){
                  context.read<AuthManage>().toggleWidgets(currentPage: 1);
                },
                child: const Text("Create account now",style:  TextStyle(
                  fontSize: fontSize17,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigoAccent,
                ),),
              ),

            ],)
          ],
        ),
      ),
    );
  }

  void signIn() async {
    debugPrint('signIn()');
    final form = formKey.currentState;
    if (form!.validate()) {
      String email = emailTEC.text;
      String password = passwordTEC.text;

      await AuthService().signInWithEmailAndPassword(
          email: email,
          password: password);

    } else {
      debugPrint('Form is invalid');
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
