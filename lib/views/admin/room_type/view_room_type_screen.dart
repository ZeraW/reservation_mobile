import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/room_api.dart';

import '../../../models/hotel.dart';
import '../../../models/room.dart';
import '../../../widgets/row/basic/room_row_widget.dart';
import 'edit_room_type_screen.dart';

class ViewRoomTypeScreen extends StatelessWidget {
  static const routeName = 'view_city_screen';

  final Hotel hotel;
  const ViewRoomTypeScreen({required this.hotel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Room>?>(
        stream: RoomApi().getLiveData(hotel.id!),
        builder: (context, snapshot) {
          List<Room>? list = snapshot.data;

          return Scaffold(
          backgroundColor: backgroundWhite,
          appBar: AppBar(
            title:  Text(
              '${hotel.name} Rooms',
              style: const TextStyle(
                color: blackFontColor,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigationService.adminInstance
                        .navigateToWidget(EditRoomScreen(all:list??[],hotelId: hotel.id!,));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: list!=null ?ListView.builder(
            itemBuilder: (context, index) {
              return RoomRowWidget(list[index],onTap: (){
                NavigationService.adminInstance
                    .navigateToWidget(EditRoomScreen(edit: list[index],hotelId: hotel.id!,all: list,));
              },);
            },
            itemCount: list.length,
          ):const SizedBox(),
        );
      }
    );
  }
}
