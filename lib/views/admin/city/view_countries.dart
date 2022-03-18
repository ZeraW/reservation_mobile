import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/views/admin/city/view_city_screen.dart';

import '../../../widgets/list/list_widget.dart';
import '../../../widgets/row/basic/country_row_widget.dart';
import 'edit_city_screen.dart';

class ViewCountries extends StatelessWidget {
  static const routeName = 'view_countries';

  const ViewCountries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Country>? list = context.watch<List<Country>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Select Country',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return CountryRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(ViewCityScreen(country:list[index] ,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
