import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/views/admin/hotel/view_hotel_screen.dart';
import 'package:reservation_mobile/views/admin/package_info/view_package_info_screen.dart';
import 'package:reservation_mobile/views/admin/package_type/view_package_type_screen.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';
import 'air_line/view_airline_screen.dart';
import 'city/view_countries.dart';
import 'country/view_country_screen.dart';
import 'flight_type/view_flight_type_screen.dart';
import 'package/view_package_screen.dart';
import 'room_type/select_hotel.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = 'admin_home';

  const AdminScreen({Key? key}) : super(key: key);

  Widget getTitle(String title, {VoidCallback? fun}) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 8, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    const Divider(),
                  ],
                ),
              ),
            ),
            onTap: () {
              if (fun != null) {
                fun();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget getExpansionList(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          title: const Text('Basic Data'),
          children: [
            getTitle(
              'Country',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewCountryScreen.routeName);
              },
            ),
            getTitle(
              'City',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewCountries.routeName);

              },
            ),
            getTitle(
              'Package Type',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewPackageTypeScreen.routeName);

              },
            ),
            getTitle(
              'Package Info',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewPackageInfoScreen.routeName);

              },
            ),
            getTitle(
              'Package',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewPackageScreen.routeName);

              },
            )
          ],
        ),
        ExpansionTile(
          title: const Text('Hotel Data'),
          children: [
            getTitle(
              'Hotel',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewHotelScreen.routeName);

              },
            ),
            getTitle(
              'Room Type',
              fun: () {
                NavigationService.adminInstance.navigateTo(SelectHotel.routeName);

              },
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('Airline Data'),
          children: [
            getTitle(
              'Airline',
              fun: () {
                NavigationService.adminInstance.navigateTo(ViewAirlineScreen.routeName);

              },
            ),
            getTitle(
              'Flight Type',
              fun: () {
              NavigationService.adminInstance.navigateTo(ViewFlightTypeScreen.routeName);

              },
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('Reservation Data'),
          children: [
            getTitle(
              'Reservation',
              fun: () {

              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          const Text(
            'Log out',
            style: TextStyle(color: whiteFontColor),
          ),
          isExpanded: true,
          color: mainRColor,
          fun: () async {

          },
        ),
      ],
    );
  }

  Widget getContent(BuildContext context) {
    return ListView(
      children: [
        getTitle('Country', fun: () {

        }),
        getTitle('City', fun: () {

        }),
        getTitle('Package Type', fun: () {

        }),
        getTitle('Package', fun: () {

        }),
        getTitle('Plan', fun: () {

        }),
        getTitle('Hotel', fun: () {

        }),
        getTitle('Room Type', fun: () {

        }),
        getTitle('Room', fun: () {

        }),
        getTitle('Airline', fun: () {

        }),
        getTitle('Flight Type', fun: () {

        }),
        getTitle('Flight', fun: () {

        }),
        getTitle('Reservation', fun: () {

        }),
        getTitle('Children', fun: () {

        }),
        getTitle('Flight Reservation', fun: () {

        }),
        getTitle('Hotel Reservation', fun: () {

        }),
        getTitle('Room Reservation', fun: () {

        }),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          const Text(
            'Log out',
            style: TextStyle(color: whiteFontColor),
          ),
          isExpanded: true,
          color: mainRColor,
          fun: () async {

          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Reservation Panel',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: getExpansionList(context),
    );
  }
}
