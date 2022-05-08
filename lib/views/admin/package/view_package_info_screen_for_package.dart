import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/views/admin/package/view_package_screen.dart';
import 'package:reservation_mobile/widgets/row/basic/package_info_row_widget.dart';

class ViewPackageInfo4PackageScreen extends StatelessWidget {
  static const routeName = 'ViewPackageInfo4PackageScreen';

  const ViewPackageInfo4PackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PackageInfo>? list = context.watch<List<PackageInfo>?>();
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Select Package Info',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return PackageInfoRowWidget(list[index],onTap: (){
                  NavigationService.adminInstance.navigateToWidget( ViewPackageScreen(pInfoId: list[index].id,));

                },);
              },
              itemCount: list.length,
            )
          : const SizedBox(),
    );
  }
}
