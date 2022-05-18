import 'package:flutter/material.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/utils/dimensions.dart';
import 'package:reservation_mobile/views/user/account_screen.dart';
import 'package:reservation_mobile/views/user/booking_screen.dart';
import 'package:reservation_mobile/views/user/home_screen.dart';
import 'package:reservation_mobile/views/user/search_screen.dart';


class UserScreen extends StatefulWidget {
  static const routeName = 'user_home';

  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  int _currentIndex = 0;
  String _pageName = 'Online tour & travel agency';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Widget>> _childrenUser = [
      {'Online tour & travel agency':const HomeScreen()},
      {'Search':const SearchScreen()},
      {'Booking':const BookingScreen(),},
      {'Account': const AccountScreen(),},
    ];
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: xColors.white,
            title: Text(
              _pageName,
              style: TextStyle(
                  color: xColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.width(5, context)),
            )),
        body: _childrenUser[_currentIndex].values.first,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: _childrenUser[1].keys.first),
            BottomNavigationBarItem(
                icon: const Icon(Icons.card_travel),
                label: _childrenUser[2].keys.first),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: _childrenUser[3].keys.first),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageName = _childrenUser[index].keys.first;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black.withOpacity(0.70),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: _currentIndex,
          elevation: 0.0,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.grey[200],
        ));
  }
}

