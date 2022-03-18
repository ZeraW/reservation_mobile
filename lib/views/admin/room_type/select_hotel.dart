import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/views/admin/city/view_city_screen.dart';
import 'package:reservation_mobile/widgets/row/basic/hotel_row_widget.dart';

import '../../../models/hotel.dart';
import '../../../widgets/list/list_widget.dart';
import '../../../widgets/row/basic/country_row_widget.dart';
import 'edit_room_type_screen.dart';
import 'view_room_type_screen.dart';

class SelectHotel extends StatelessWidget {
  static const routeName = 'select_hotel';

  const SelectHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Hotel>? list = context.watch<List<Hotel>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Select Hotel',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return HotelRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(ViewRoomTypeScreen(hotel:list[index] ,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
