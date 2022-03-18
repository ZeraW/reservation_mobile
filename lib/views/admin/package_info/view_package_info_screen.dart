import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/widgets/row/basic/package_info_row_widget.dart';

import 'edit_package_info_screen.dart';

class ViewPackageInfoScreen extends StatelessWidget {
  static const routeName = 'view_package_info_screen';

  const ViewPackageInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PackageInfo>? list = context.watch<List<PackageInfo>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Package Info',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditPackageInfoScreen(all:list??[]));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return PackageInfoRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance
                      .navigateToWidget(EditPackageInfoScreen(edit: list[index],all: list,));
                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
