import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';

import 'reservation/reservation_screen.dart';

class PackageResult extends StatelessWidget {
  final PackageInfo packageInfo;
  const PackageResult(this.packageInfo,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Package',
          style: TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: StreamBuilder<List<Package>>(
        stream: PackageApi().getPackagesByPackageInfo(pInfo: packageInfo.id),
        builder: (context, snapshot) {
          List<Package>? pList = snapshot.data;
          return ResultList(pList: pList ?? [],);
        }
      ),
    );
  }
}

class ResultList extends StatelessWidget {
 final List<Package> pList;
  const ResultList({required this.pList,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Country>? listCountry = context.watch<List<Country>?>();
    List<City>? listCity = context.watch<List<City>?>();

    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
      child:  listCountry != null && listCity != null
          ? Column(
            children: [
              Align(alignment: AlignmentDirectional.centerEnd,child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('( ${pList.length} ) Package found'),
              )),
              Expanded(
                child: ListView.builder(
        itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: ListTile(
                    onTap: () {
                      NavigationService.userInstance.navigateToWidget(
                          ChangeNotifierProvider(
                              create: (context) => ReservationManage(
                                  Reservation(
                                      packagePrice: pList[index].keyWords!['price'],
                                      userId:FirebaseAuth.instance.currentUser?.uid,
                                      packageId: pList[index].id,
                                      canceled: false
                                  ),pList[index].keyWords!['country'],pList[index].keyWords!['city']),
                              child: const ReservationScreen()));
                    },
                    title: Text('${pList[index].keyWords!['name']}'),
                    tileColor: Colors.black.withOpacity(0.03),
                    subtitle: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                                '${Country().getCountryName(id: pList[index].keyWords!['country'], list: listCountry)} , '),
                            Text(City().getCityName(
                                id: pList[index].keyWords!['city'],
                                list: listCity)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                                '${pList[index].departAt!.day}-${pList[index].departAt!.month}-${pList[index].departAt!.year} , '),
                            Text(
                                '${pList[index].returnAt!.day}-${pList[index].returnAt!.month}-${pList[index].returnAt!.year}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        },
        itemCount: pList.length,
      ),
              ),
            ],
          )
          : const SizedBox(),
    );
  }
}
