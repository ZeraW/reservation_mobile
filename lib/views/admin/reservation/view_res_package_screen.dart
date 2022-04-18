import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';
import 'package:reservation_mobile/views/admin/reservation/view_res_screen.dart';
import '../../../models/package.dart';
import '../../../widgets/row/basic/package_row_widget.dart';

class ViewReservationPackageScreen extends StatefulWidget {
  static const routeName = 'view_reservation_package_screen';

  const ViewReservationPackageScreen({Key? key}) : super(key: key);

  @override
  State<ViewReservationPackageScreen> createState() => _ViewReservationPackageScreenState();
}

class _ViewReservationPackageScreenState extends State<ViewReservationPackageScreen> {

  bool isUpcoming = true;
  Color cardColor = Colors.grey.withOpacity(0.50);
  Color textColor = Colors.black.withOpacity(0.60);
  @override
  Widget build(BuildContext context) {
    List<PackageInfo>? listPInfo = context.watch<List<PackageInfo>?>();

    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        title: const Text(
          'Select Package',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() {
                          isUpcoming = true;
                        }),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                              isUpcoming ? cardColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Upcoming',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: textColor),
                          ),
                        ))),
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() {
                          isUpcoming = false;
                        }),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                              !isUpcoming ? cardColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Past',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: textColor),
                          ),
                        ))),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Package>>(
                stream: PackageApi().getPackagesByDate(isUpcoming: isUpcoming),
                builder:  (context, snapshot) {
                  List<Package>? list = snapshot.data;

                  return list != null && listPInfo != null
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return PackageRowWidget(
                            list[index],
                            packageInfo: listPInfo.firstWhere(
                                (element) => element.id == list[index].packetInfoId,
                              orElse: () => PackageInfo(id: 'null', name: 'Removed')
                            ),
                            onTap: () {
                              NavigationService.adminInstance.navigateToWidget(ViewReservationScreen(packageId: list[index].id!,));
                            },
                          );
                        },
                        itemCount: list.length,
                      )
                    : const SizedBox();
              }
            ),
          ),
        ],
      ),
    );
  }
}
