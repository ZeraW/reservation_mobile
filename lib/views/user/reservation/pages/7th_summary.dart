import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResSummary extends StatelessWidget {
  const ResSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    List<Package>? pList = context.watch<List<Package>?>();
    List<PackageInfo>? pInfoList = context.watch<List<PackageInfo>?>();
    List<Country>? countryList = context.watch<List<Country>?>();
    List<City>? cityList = context.watch<List<City>?>();
    List<Room>? roomList = context.watch<List<Room>?>();
    List<Hotel>? hotelList = context.watch<List<Hotel>?>();
    List<Airline>? airLineList = context.watch<List<Airline>?>();
    List<FlightType>? flightTypeList = context.watch<List<FlightType>?>();

    Package? package = pList != null
        ? Package().getPackage(list: pList, id: provider.reservation.packageId!)
        : null;
    PackageInfo? packageInfo = package != null && pInfoList != null
        ? PackageInfo()
            .getPackageInfo(list: pInfoList, id: package.packetInfoId!)
        : null;
    Hotel? hotel = hotelList != null
        ? Hotel().getHotel(list: hotelList, id: provider.reservation.hotelId!)
        : null;
    Airline? airline = airLineList != null
        ? Airline()
            .getAirline(list: airLineList, id: provider.reservation.airLineId!)
        : null;
    FlightType? flightType = flightTypeList != null
        ? FlightType().getFlightType(
            list: flightTypeList, id: provider.reservation.flightTypeId!)
        : null;

    return package != null &&
            packageInfo != null &&
            countryList != null &&
            airline != null &&
            flightType != null &&
            cityList != null &&
        roomList != null &&
            hotel != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Package Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
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
                              Text('Country:  ${Country().getCountryName(list: countryList, id: packageInfo.destinationCountryId!)}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('City: ${City().getCityName(list: cityList, id: packageInfo.destinationCityId!)}'),
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
                        height: 20,
                      ),
                      const Text(
                        'Hotel & Room Info.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
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
                              Text('Room: ${getRooms(roomList,provider.reservation.roomsAndCount!)}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Price: ${provider.reservation.hotelPrice}'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Flight Info.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
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
                              Text('Travelers no. : ${provider.reservation.capacity}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Airline: ${airline.name}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Flight Type: ${flightType.name}'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Price: ${provider.reservation.flightPrice}'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Total Cost',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
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
                                  'Package Price: ${provider.reservation.packagePrice} L.E'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Flight Price: ${provider.reservation.flightPrice} L.E'),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Hotel Price: ${provider.reservation.hotelPrice} L.E'),
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                  'Total Price: ${provider.reservation.totalPrice} L.E'),
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
              ButtonWidget(
                const Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                isExpanded: true,
                color: xColors.mainColor,
                fun: () {
                  provider.goTo(8);
                },
              ),
            ],
          )
        : const SizedBox();
  }


  String getRooms(List<Room> rooms,Map<String , int > roomsAndCount){
    String roomie = '';
    for(var ro in roomsAndCount.entries){
      roomie = roomie + ro.value.toString()+"x "+Room().getRoom(list: rooms, id: ro.key).name!+" , ";
    }
    return roomie;
  }
}
