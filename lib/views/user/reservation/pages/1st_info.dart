import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResInfo extends StatelessWidget {
  const ResInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    List<Package>? pList = context.watch<List<Package>?>();
    List<PackageInfo>? pInfoList = context.watch<List<PackageInfo>?>();
    List<Country>? countryList = context.watch<List<Country>?>();
    List<City>? cityList = context.watch<List<City>?>();

    Package? package = pList != null
        ? Package().getPackage(list: pList, id: provider.reservation.packageId!)
        : null;
    PackageInfo? packageInfo = package != null && pInfoList != null
        ? PackageInfo().getPackageInfo(list: pInfoList, id: package.packetInfoId!) : null;

    return package != null &&
        packageInfo != null &&
            countryList != null &&
            cityList != null
        ? SingleChildScrollView(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${package.keyWords!['name']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageHolder,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start Date: ${package.departAt}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('End Date:  ${package.returnAt}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Country:  ${Country().getCountryName(list: countryList, id: packageInfo.destinationCountryId!)}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('City: ${City().getCityName(list: cityList, id: packageInfo.destinationCityId!)}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('No. of Days: ${packageInfo.daysNum}'),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text('${packageInfo.description}'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Program',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i=0;i<packageInfo.planList!.length;i++ )
                          Text('day${i+1}: ${packageInfo.planList![i]} ',style: TextStyle(height: 1.5),),

                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child:  Text(
                    'Initial Price ${packageInfo.price}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  const Text(
                    'START RESERVATION',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  isExpanded: true,
                  color: xColors.mainColor,
                  fun: () {
                    if(package.remaining!>0){
                      provider.updateMaxCount(package.remaining!);
                      provider.updateDate(package.departAt!.millisecondsSinceEpoch,package.returnAt!.millisecondsSinceEpoch);
                      provider.updateDays(packageInfo.daysNum!);
                      provider.goTo(2);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ))
        : const Center(child: CircularProgressIndicator());
  }
}
