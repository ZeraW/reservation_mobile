import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/user.dart';
import 'package:reservation_mobile/server/auth.dart';
import 'package:reservation_mobile/server/firebase/user_api.dart';

import '../../constants/constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/textfield_widget.dart';



class AccountScreen extends StatefulWidget {
  static  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

   const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController nameTEC = TextEditingController();

  final TextEditingController phoneTEC = TextEditingController();

  final TextEditingController emailTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.watch<UserModel?>();

    if(user!=null){
      if(nameTEC.text.isEmpty) {
        nameTEC.text = user.name!;
      }
      if(phoneTEC.text.isEmpty) {
        phoneTEC.text = user.phone!;
      }
      emailTEC.text = user.email!;
    }


    return user!=null ? FormBuilder(
      key: AccountScreen.formKey,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
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
              enabled: false,
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
            ButtonWidget(
              const Text('Update Info',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              color: xColors.black,
              isExpanded: true,
              fun: () {
                updateInfo(user);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonWidget(
              const Text('Logout',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              color: Colors.red,
              isExpanded: true,
              fun: () {
                AuthService().signOut();
              },
            ),

          ],
        ),
      ),
    ):SizedBox();
  }

  void updateInfo(UserModel user) async {
    final form = AccountScreen.formKey.currentState;
    if (form!.validate()) {

      String name = nameTEC.text;
      String  phone = phoneTEC.text;

      UserModel updatedUser = UserModel(id: user.id,phone: phone,name: name,email:  user.email!,password: user.password!,userType:  user.userType!);

      await UserApi().updateUserData(user: updatedUser);


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

