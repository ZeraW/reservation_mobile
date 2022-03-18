import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/package_type.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/widgets/row/basic/package_type_row_widget.dart';

import 'edit_package_type_screen.dart';


class ViewPackageTypeScreen extends StatelessWidget {
  static const routeName = 'view_package_type_screen';

  const ViewPackageTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PackageType>? list = context.watch<List<PackageType>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Package Type',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditPackageTypeScreen(all:list??[]));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return PackageTypeRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(EditPackageTypeScreen(edit: list[index],all: list,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
