import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResHotel extends StatelessWidget {
  const ResHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Hotel>? hotelList = context.watch<List<Hotel>?>();
    List<Country>? countryList = context.watch<List<Country>?>();
    List<City>? cityList = context.watch<List<City>?>();
    final provider = context.watch<ReservationManage>();

    return hotelList != null && countryList!=null && cityList!=null
        ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    Hotel hotel = hotelList[index];
                    return hotel.countryId == provider.country && hotel.cityId == provider.city ?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${hotel.name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/reservation-7f6b8.appspot.com/o/holder.jpg?alt=media&token=a87e51f9-ab72-4e69-9112-b54c7bc7da6a',
                            width: double.infinity,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          'Information',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.black.withOpacity(0.78)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${hotel.desc}',maxLines: 2,style: TextStyle(color: Colors.black.withOpacity(0.70)),),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('${Country().getCountryName(list: countryList, id: hotel.countryId!)} '
                                      ', ${City().getCityName(list: cityList, id: hotel.cityId!)}',style: TextStyle(color: Colors.black.withOpacity(0.70)),),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('(${hotel.rate}) ★',style: TextStyle(color: Colors.black.withOpacity(0.70)),),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 45,
                                child: ButtonWidget(
                                   Text(
                                    provider.reservation.hotelId!=null &&  provider.reservation.hotelId== hotel.id? 'SELECTED':'SELECT',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  isExpanded: true,
                                  color: provider.reservation.hotelId!=null &&  provider.reservation.hotelId== hotel.id? Colors.black38: Colors.black,
                                  fun: () {
                                     if(provider.reservation.hotelId!=null &&  provider.reservation.hotelId== hotel.id){

                                     }else{
                                       provider.updateHotel(hotel.id!);

                                     }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ):const SizedBox();
                  },
                  itemCount: hotelList.length,
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
                if (provider.reservation.hotelId != null) {
                  provider.resetRooms();
                  provider.goTo(4);
                }else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      "You must select a hotel",
                    ),
                    action: SnackBarAction(
                      textColor: Colors.white,
                      label: 'i understand',
                      onPressed: () {},
                    ),
                  ));
                }
              },
            ),
          ],
        )
        : const SizedBox();
  }
}
