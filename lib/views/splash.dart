import 'package:flutter/material.dart';
import '../navigation_service.dart';
import '../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double x = 0;


  @override
  void initState() {
    super.initState();
    delay();
  }

  void delay() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      NavigationService.instance.key.currentState!.pushReplacementNamed(
        'Wrapper',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.cover,
          height: Responsive.isMobile(context)?Responsive.width(50.0, context):200,
          width:Responsive.isMobile(context)?Responsive.width(50.0, context):200,
        ),
      ),
    );
  }

}
