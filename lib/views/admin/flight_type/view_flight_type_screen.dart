import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/navigation_service.dart';

import '../../../widgets/row/basic/flight_type_row_widget.dart';
import 'edit_flight_type_screen.dart';

class ViewFlightTypeScreen extends StatelessWidget {
  static const routeName = 'view_flightType_screen';

  const ViewFlightTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlightType>? list = context.watch<List<FlightType>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Flight Type',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditFlightTypeScreen(all:list??[]));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return FlightTypeRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(EditFlightTypeScreen(edit: list[index],all: list,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
