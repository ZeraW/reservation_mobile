import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/reservation_api.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/widgets/widget_to_png.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../../models/user.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool isUpcoming = true;
  Color cardColor = Colors.grey.withOpacity(0.50);
  Color textColor = Colors.black.withOpacity(0.60);

  @override
  Widget build(BuildContext context) {
    List<Package>? pList = context.watch<List<Package>?>();

    return Padding(
        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() {
                              isUpcoming = true;
                            }),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  isUpcoming ? cardColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Upcoming',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: textColor),
                          ),
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() {
                              isUpcoming = false;
                            }),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  !isUpcoming ? cardColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Past',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: textColor),
                          ),
                        ))),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder<List<Reservation>>(
                  stream: ReservationApi()
                      .query(user: FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    List<Reservation>? myData = snapshot.data;

                    return myData != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              Reservation res = myData[index];
                              bool isNew =
                                  res.departAt! >= dateToInt(DateTime.now());
                              bool isOld =
                                  res.departAt! < dateToInt(DateTime.now());
                              bool show = isUpcoming ? isNew : isOld;
                              return show
                                  ? BookingCard(
                                      data: myData[index],
                                      pList: pList,
                                    )
                                  : const SizedBox();
                            },
                            itemCount: myData.length,
                          )
                        : const SizedBox();
                  }),
            )
          ],
        ));
  }

  int dateToInt(DateTime i) {
    return DateTime(i.year, i.month, i.day).millisecondsSinceEpoch;
  }
}

class BookingCard extends StatelessWidget {
  final Color cardColor = Colors.grey.withOpacity(0.50);
  final Color textColor = Colors.black.withOpacity(0.60);
  final Reservation data;
  List<Package>? pList;
  BookingCard({required this.data,required this.pList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Package? package = pList != null
        ? Package().getPackage(list: pList!, id: data.packageId!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                    color: cardColor, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Package : ${package!=null ? package.keyWords!['name']:''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(color: textColor, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Start Date : ${DateTime.fromMillisecondsSinceEpoch(data.departAt!)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: textColor, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Return Date : ${DateTime.fromMillisecondsSinceEpoch(data.returnAt!)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: textColor, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Booking no. : ${data.id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: textColor, fontWeight: FontWeight.w500),
                    ),

                  ],
                )),
            data.canceled!? Positioned(
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ) // green shaped
                ),
                child: const Text("Canceled",style: TextStyle(color: Colors.white),),
              ),
            ):const SizedBox()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ButtonWidget(
            const Text('View Details', style: TextStyle(fontSize: 17)),
            isExpanded: true,
            fun: () {
              NavigationService.userInstance
                  .navigateToWidget(ResSummary(reservation: data));
            },
            color: xColors.mainColor,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ResSummary extends StatelessWidget {
  final Reservation reservation;
  late GlobalKey key1;

  ResSummary({required this.reservation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Package>? pList = context.watch<List<Package>?>();
    List<PackageInfo>? pInfoList = context.watch<List<PackageInfo>?>();
    List<Country>? countryList = context.watch<List<Country>?>();
    List<City>? cityList = context.watch<List<City>?>();
    List<Room>? roomList = context.watch<List<Room>?>();
    List<Hotel>? hotelList = context.watch<List<Hotel>?>();
    List<Airline>? airLineList = context.watch<List<Airline>?>();
    List<FlightType>? flightTypeList = context.watch<List<FlightType>?>();
    List<UserModel>? usersList = context.watch<List<UserModel>?>();

    Package? package = pList != null
        ? Package().getPackage(list: pList, id: reservation.packageId!)
        : null;
    PackageInfo? packageInfo = package != null && pInfoList != null
        ? PackageInfo()
            .getPackageInfo(list: pInfoList, id: package.packetInfoId!)
        : null;
    Hotel? hotel = hotelList != null
        ? Hotel().getHotel(list: hotelList, id: reservation.hotelId!)
        : null;
    Airline? airline = airLineList != null
        ? Airline().getAirline(list: airLineList, id: reservation.airLineId!)
        : null;
    FlightType? flightType = flightTypeList != null
        ? FlightType()
            .getFlightType(list: flightTypeList, id: reservation.flightTypeId!)
        : null;



    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            await Utils.print(key: key1, context: context, id: '${reservation.id}');
          }, icon: const Icon(Icons.print))
        ],
      ),
      body: package != null &&
              packageInfo != null &&
              countryList != null &&
              airline != null &&
              flightType != null &&
              cityList != null &&
              roomList != null &&
              hotel != null && usersList != null
          ? WidgetToImage(builder: (key) {
            key1 = key;
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Reservation Info.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black.withOpacity(0.05),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('User: ${UserModel().getUserName(list: usersList, id: reservation.userId!)}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Booking ID: ${reservation.id}'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Package Information',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black.withOpacity(0.05),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Start Date: ${package.departAt}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('End Date:  ${package.returnAt}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Country:  ${Country().getCountryName(list: countryList, id: packageInfo.destinationCountryId!)}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'City: ${City().getCityName(list: cityList, id: packageInfo.destinationCityId!)}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('No. of Days: ${packageInfo.daysNum}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Hotel & Room Info.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black.withOpacity(0.05),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hotel: ${hotel.name}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Room: ${getRooms(roomList, reservation.roomsAndCount!)}'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Flight Info.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black.withOpacity(0.05),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Travelers no. : ${reservation.capacity}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('Airline: ${airline.name}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('Flight Type: ${flightType.name}'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Total Cost',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black.withOpacity(0.05),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Package Price: ${reservation.packagePrice} L.E'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Flight Price: ${reservation.flightPrice} L.E'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Hotel Price: ${reservation.hotelPrice} L.E'),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Text(
                                      'Total Price: ${reservation.totalPrice} L.E'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*ButtonWidget(
              const Text(
                'Continue',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              isExpanded: true,
              color: xColors.mainColor,
              fun: () {
                provider.goTo(8);
              },
            ),*/
                ],
              ),
            );
          })
          : const SizedBox(),
    );
  }

  String getRooms(List<Room> rooms, Map<String, int> roomsAndCount) {
    String roomie = '';
    for (var ro in roomsAndCount.entries) {
      roomie = roomie +
          ro.value.toString() +
          "x " +
          Room().getRoom(list: rooms, id: ro.key).name! +
          " , ";
    }
    return roomie;
  }
}
