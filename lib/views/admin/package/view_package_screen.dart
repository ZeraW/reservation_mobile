import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/navigation_service.dart';
import '../../../models/package.dart';
import '../../../widgets/row/basic/package_row_widget.dart';
import 'edit_package_screen.dart';

class ViewPackageScreen extends StatelessWidget {
  static const routeName = 'view_package_screen';

  const ViewPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Package>? list = context.watch<List<Package>?>();
    List<PackageInfo>? listPInfo = context.watch<List<PackageInfo>?>();

    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Package',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.adminInstance
                    .navigateToWidget(EditPackageScreen(all: list ?? []));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: list != null && listPInfo != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return PackageRowWidget(
                  list[index],
                  packageInfo: listPInfo.firstWhere(
                      (element) => element.id == list[index].packetInfoId,
                    orElse: () => PackageInfo(id: 'null', name: 'Removed')
                  ),
                  onTap: () {
                    NavigationService.adminInstance
                        .navigateToWidget(EditPackageScreen(
                      edit: list[index],
                      all: list,
                    ));
                  },
                );
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
