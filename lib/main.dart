import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:reservation_mobile/server/auth.dart';
import 'package:reservation_mobile/utils/themes.dart';
import 'navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(value: AuthService().user, initialData: null,),

      ],
      child: MaterialApp(
        title: 'Reservation App',
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.instance.key,
        routes: routes,
        theme: appTheme(),
        initialRoute: '/',
      ),
    );
  }
}
