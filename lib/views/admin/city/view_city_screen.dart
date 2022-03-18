import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/navigation_service.dart';

import '../../../models/city.dart';
import '../../../server/firebase/city_api.dart';
import '../../../widgets/row/basic/city_row_widget.dart';
import 'edit_city_screen.dart';

class ViewCityScreen extends StatelessWidget {
  static const routeName = 'view_city_screen';

  final Country? country;
  const ViewCityScreen({this.country,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<City>?>(
        stream: CityApi().getLiveData(country!.id!),
        builder: (context, snapshot) {
          List<City>? list = snapshot.data;

          return Scaffold(
          backgroundColor: backgroundWhite,
          appBar: AppBar(
            title:  Text(
              '${country!.name} Cities',
              style: const TextStyle(
                color: blackFontColor,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigationService.adminInstance
                        .navigateToWidget(EditCityScreen(all:list??[],countryId: country!.id!,));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: list!=null ?ListView.builder(
            itemBuilder: (context, index) {
              return CityRowWidget(list[index],onTap: (){
                NavigationService.adminInstance
                    .navigateToWidget(EditCityScreen(edit: list[index],countryId: country!.id!,all: list,));
              },);
            },
            itemCount: list.length,
          ):const SizedBox(),
        );
      }
    );
  }
}
