import 'package:flutter/widgets.dart';
import 'package:reservation_mobile/views/admin/admin_screen.dart';
import 'package:reservation_mobile/views/admin/air_line/view_airline_screen.dart';
import 'package:reservation_mobile/views/admin/city/view_countries.dart';
import 'package:reservation_mobile/views/admin/country/edit_country_screen.dart';
import 'package:reservation_mobile/views/admin/country/view_country_screen.dart';
import 'package:reservation_mobile/views/admin/flight_type/view_flight_type_screen.dart';
import 'package:reservation_mobile/views/admin/hotel/view_hotel_screen.dart';
import 'package:reservation_mobile/views/admin/package/view_package_screen.dart';
import 'package:reservation_mobile/views/admin/package_info/view_package_info_screen.dart';
import 'package:reservation_mobile/views/admin/package_type/view_package_type_screen.dart';
import 'package:reservation_mobile/views/splash.dart';
import 'package:reservation_mobile/wrapper.dart';

import 'views/admin/city/view_city_screen.dart';
import 'views/admin/room_type/select_hotel.dart';



final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const SplashScreen(),
  "Wrapper": (BuildContext context) => const Wrapper(),
  AdminScreen.routeName :  (BuildContext context) => const AdminScreen(),
  ViewCountryScreen.routeName :  (BuildContext context) => const ViewCountryScreen(),
  ViewCityScreen.routeName :  (BuildContext context) => const ViewCityScreen(),
  ViewCountries.routeName :  (BuildContext context) => const ViewCountries(),
  ViewAirlineScreen.routeName :  (BuildContext context) => const ViewAirlineScreen(),
  ViewFlightTypeScreen.routeName :  (BuildContext context) => const ViewFlightTypeScreen(),
  ViewHotelScreen.routeName :  (BuildContext context) => const ViewHotelScreen(),
  SelectHotel.routeName :  (BuildContext context) => const SelectHotel(),
  ViewPackageTypeScreen.routeName :  (BuildContext context) => const ViewPackageTypeScreen(),
  ViewPackageInfoScreen.routeName :  (BuildContext context) => const ViewPackageInfoScreen(),
  ViewPackageScreen.routeName :  (BuildContext context) => const ViewPackageScreen(),







};


