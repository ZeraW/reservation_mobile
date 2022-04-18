import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/package_type.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/package_info_api.dart';
import 'package:reservation_mobile/views/user/package_result.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PackageType>? pTypeList = context.watch<List<PackageType>?>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 15, top: 15),
        child: pTypeList != null
            ? ListView.builder(
          itemBuilder: (context, index) {
            return PackageList(pTypeList[index]);
          },
          itemCount: pTypeList.length,
        )
            : const SizedBox(),
      ),
    );
  }
}

class PackageList extends StatelessWidget {
  final PackageType pType;

  const PackageList(this.pType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(double.infinity, 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${pType.name}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: StreamBuilder<List<PackageInfo>>(
                stream: PackageInfoApi().queryByType(pType.id!),
                builder: (context, snapshot) {
                  List<PackageInfo>? list = snapshot.data;

                  return list != null ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            NavigationService.userInstance.navigateToWidget(
                                PackageResult(list[index])
                            );

                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    color: Colors.grey[200],
                                    child: list[index].image != null ? Image
                                        .network(
                                      '${list[index].image}', fit: BoxFit.cover,):const SizedBox(),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${list[index].name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: list.length,
                    scrollDirection: Axis.horizontal,
                  ) : Text('No Packages Available in ${pType.name}');
                }
            ),
          )
        ],
      ),
    );
  }
}
