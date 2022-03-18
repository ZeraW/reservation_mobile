import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';

import '../../../models/airline.dart';
import '../../../widgets/row/basic/airlane_row_widget.dart';
import 'edit_airline_screen.dart';

class ViewAirlineScreen extends StatelessWidget {
  static const routeName = 'view_airline_screen';

  const ViewAirlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Airline>? list = context.watch<List<Airline>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'AirLine',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditAirLineScreen(all:list??[]));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return AirlineRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(EditAirLineScreen(edit: list[index],all: list,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
