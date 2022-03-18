import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/navigation_service.dart';

import '../../../widgets/list/list_widget.dart';
import '../../../widgets/row/basic/country_row_widget.dart';
import 'edit_country_screen.dart';

class ViewCountryScreen extends StatelessWidget {
  static const routeName = 'view_country_screen';

  const ViewCountryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Country>? list = context.watch<List<Country>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Country',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditCountryScreen(all:list??[]));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return CountryRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(EditCountryScreen(edit: list[index],all: list,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
