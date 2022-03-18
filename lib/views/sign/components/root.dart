import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../server/auth_manage.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthManage>(builder: (context, auth, child) {
        return WillPopScope(
            onWillPop: () async {
              // You can do some work here.
              // Returning true allows the pop to happen, returning false prevents it.
              auth.onBackPressed();
              return false;
            }, child: auth.currentWidget());
      }),
    );
  }
}