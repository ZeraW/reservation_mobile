import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/widgets/row/basic/hotel_row_widget.dart';

import 'edit_hotel_screen.dart';

class ViewHotelScreen extends StatelessWidget {
  static const routeName = 'view_hotel_screen';

  const ViewHotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Hotel>? list = context.watch<List<Hotel>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Hotel',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditHotelScreen(all:list??[]));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return HotelRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(EditHotelScreen(edit: list[index],all: list,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
