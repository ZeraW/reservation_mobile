import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/user.dart';
import 'package:reservation_mobile/utils/colors.dart';
import '../../../constants/constants.dart';
import '../../../server/auth.dart';
import '../../../server/auth_manage.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class SignUpFormWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController confirmPasswordTEC = TextEditingController();

  SignUpFormWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: Responsive.height(5, context),
            ),
            const Text(
              'Sign up',
              style: TextStyle(
                fontSize: fontSize25,
                fontWeight: FontWeight.bold,
                color: xColors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormBuilder(
              hint: "Name",
              controller: nameTEC,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
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
              hint: "Phone",
              controller: phoneTEC,
              validator: (value) {
                if (value!.isEmpty || value.length<11) {
                  return "Enter a valid phone number";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormBuilder(
              hint: "Password",
              isPassword: true,
              controller: passwordTEC,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter password";
                }else if(value.length<6){
                  return "Password must be 6+ char";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormBuilder(
              hint: "Confirm Password",
              isPassword: true,
              controller: confirmPasswordTEC,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter confirm password";
                }else if(value!=passwordTEC.text){
                  return "confirm password doesn't match password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonWidget(
              const Text('Create Account',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              color: xColors.black,
              isExpanded: true,
              fun: () {
                signUp();
              },
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    debugPrint('signUp()');
    final form = formKey.currentState;
    if (form!.validate()) {

      String name = nameTEC.text;
      String  phone = phoneTEC.text;
      String email  = emailTEC.text;
      String password = passwordTEC.text;

      UserModel newUser = UserModel(phone: phone,name: name,email: email,password: password,userType: 'user');

      await AuthService().registerWithEmailAndPassword(newUser: newUser);


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