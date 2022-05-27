import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/package_type.dart';
import 'package:reservation_mobile/models/report.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/routes.dart';
import 'package:reservation_mobile/server/auth.dart';
import 'package:reservation_mobile/server/firebase/airline_api.dart';
import 'package:reservation_mobile/server/firebase/city_api.dart';
import 'package:reservation_mobile/server/firebase/country_api.dart';
import 'package:reservation_mobile/server/firebase/flight_type_api.dart';
import 'package:reservation_mobile/server/firebase/hotel_api.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';
import 'package:reservation_mobile/server/firebase/package_info_api.dart';
import 'package:reservation_mobile/server/firebase/package_type_api.dart';
import 'package:reservation_mobile/server/firebase/report_api.dart';
import 'package:reservation_mobile/server/firebase/room_api.dart';
import 'package:reservation_mobile/server/firebase/user_api.dart';
import 'package:reservation_mobile/utils/themes.dart';
import 'models/package.dart';
import 'models/user.dart';
import 'navigation_service.dart';
import 'server/auth_manage.dart';
import 'views/sign/components/root.dart';
import 'views/user/user_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    // return either the Home or Authenticate widget
    if (user == null) {
      return ChangeNotifierProvider(
          create: (context) => AuthManage(), child: const RootScreen());
    } else {
      return StreamBuilder<UserModel>(
          stream: UserApi().getCurrentUser,
          builder: (context, snapshot) {
            UserModel? model = snapshot.data;
            if (model != null && model.userType == 'admin'||model?.userType =='manger') {
              return MultiProvider(providers: [
                StreamProvider<List<Country>?>.value(
                    value: CountryApi().getLiveData, initialData: null,),
                StreamProvider<List<ReportModel>?>.value(
                  value: ReportApi().getLiveReports, initialData: null,),
                StreamProvider<UserModel?>.value(
                  value: UserApi().getCurrentUser, initialData: null,),
                StreamProvider<List<UserModel>?>.value(
                  value: UserApi().getLiveUsers, initialData: null,),
                StreamProvider<List<City>?>.value(
                  value: CityApi().getAllLiveData, initialData: null,),
                StreamProvider<List<Airline>?>.value(
                  value: AirlineApi().getLiveData, initialData: null,),
                StreamProvider<List<FlightType>?>.value(
                  value: FlightTypeApi().getLiveData, initialData: null,),
                StreamProvider<List<Hotel>?>.value(
                  value: HotelApi().getLiveData, initialData: null,),
                StreamProvider<List<PackageType>?>.value(
                  value: PackageTypeApi().getLiveData, initialData: null,),
                StreamProvider<List<PackageInfo>?>.value(
                  value: PackageInfoApi().getLiveData, initialData: null,),
                StreamProvider<List<Package>?>.value(
                  value: PackageApi().getLiveData, initialData: null,),
              ], child: MaterialApp(
                  title: 'admin',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: NavigationService.adminInstance.key,
                  initialRoute: 'admin_home',

                  theme: appTheme(),
                  routes: routes,
                ),
              );
            }
            else if(model != null && model.userType == 'user'){
              return MultiProvider(providers: [
                StreamProvider<List<Country>?>.value(
                  value: CountryApi().getLiveData, initialData: null,),
                StreamProvider<List<UserModel>?>.value(
                  value: UserApi().getLiveUsers, initialData: null,),
                StreamProvider<UserModel?>.value(
                  value: UserApi().getCurrentUser, initialData: null,),
                StreamProvider<List<City>?>.value(
                  value: CityApi().getAllLiveData, initialData: null,),
                StreamProvider<List<Airline>?>.value(
                  value: AirlineApi().getLiveData, initialData: null,),
                StreamProvider<List<FlightType>?>.value(
                  value: FlightTypeApi().getLiveData, initialData: null,),
                StreamProvider<List<Hotel>?>.value(
                  value: HotelApi().getLiveData, initialData: null,),
                StreamProvider<List<PackageType>?>.value(
                  value: PackageTypeApi().getLiveData, initialData: null,),
                StreamProvider<List<PackageInfo>?>.value(
                  value: PackageInfoApi().getLiveData, initialData: null,),
                StreamProvider<List<Package>?>.value(
                  value: PackageApi().getLiveData, initialData: null,),
                StreamProvider<List<Room>?>.value(
                  value: RoomApi().getAllLiveData, initialData: null,),
              ], child: MaterialApp(
                  title: 'user',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: NavigationService.userInstance.key,
                  initialRoute: 'user_home',
                  theme: appTheme(),
                  routes: routes,
                ),
              );
            }else{
              return const SizedBox();
            }
          });
    }
  }
}
