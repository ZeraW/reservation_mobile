import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/report.dart';
import 'package:reservation_mobile/models/reservation.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/utils/dimensions.dart';

class FinancialReportScreen extends StatelessWidget {
  const FinancialReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReportModel>? report = context.watch<List<ReportModel>?>();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Financial Report',
            style: TextStyle(
                color: xColors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.width(5, context)),
          )),
      body: report != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'System gain in ${report[0].id} :',
                            style: TextStyle(
                                color: xColors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.width(5, context)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ProfitWidget(
                              title: 'Annual Gain',
                              profit: '${report[0].totalProfit!['price']}',
                              count: '${report[0].totalCount!['count']}'),
                          const SizedBox(
                            height: 10,
                          ),
                          ProfitWidget(
                              title: 'Semi-annual 1-6',
                              profit: '${report[0].totalProfit!['1st']}',
                              count: '${report[0].totalCount!['1st']}'),
                          const SizedBox(
                            height: 10,
                          ),
                          ProfitWidget(
                              title: 'Semi-annual 7-12',
                              profit: '${report[0].totalProfit!['2nd']}',
                              count: '${report[0].totalCount!['2nd']}'),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        'Date : ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                        style: TextStyle(
                            color: xColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.width(4.5, context))),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}

class ProfitWidget extends StatelessWidget {
  final String title;

  final String profit;

  final String count;

  const ProfitWidget(
      {Key? key,
      required this.title,
      required this.profit,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '- $title :',
            style: TextStyle(
                color: xColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: Responsive.width(4.5, context)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              const Text('Profits : '),
              Text(
                '$profit L.E',
                style:
                    const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              const Text('Tickets : '),
              Text(
                count,
                style:
                    const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ManagementWidget extends StatelessWidget {
 final String title;
 final String first;
 final String second;
 final String third;
 final String firstCount;
 final String secondCount;
 final String thirdCount;

  const ManagementWidget(
      {Key? key, required this.title,
      required this.first,
      required this.second,
      required this.third,
      required this.firstCount,
      required this.secondCount,
      required this.thirdCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '- $title :',
            style: TextStyle(
                color: xColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: Responsive.width(4.5, context)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text('1st : '),
              Text(
                first,
                style:
                    const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
              Text(
                '  ( $firstCount )',
                style:
                    const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text('2nd : '),
              Text(
                second,
                style:
                    const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
              Text(
                '  ( $secondCount )',
                style:
                    const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text('3rd : '),
              Text(
                third,
                style:
                    const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
              Text(
                '  ( $thirdCount )',
                style:
                    const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ManagementReportScreen extends StatelessWidget {
  const ManagementReportScreen({Key? key}) : super(key: key);

  String getPackage1st(int rank, List<Package> mPackageList, List<PackageInfo> pInfoList,ReportModel report) {
    return report.topCountSecond!.length < rank + 1 ? ''
        : pInfoList.firstWhere((element) => element.id == mPackageList.firstWhere((element) => element.id == report.topCountFirst!.keys.elementAt(rank)).packetInfoId!,orElse: ()=>PackageInfo(name: 'removed')).name!;
  }



  String getPackage2nd(int rank, List<Package> mPackageList,List<PackageInfo> pInfoList,
      ReportModel report) {
    return report.topCountSecond!.length < rank + 1 ? ''
        : pInfoList.firstWhere((element) => element.id == mPackageList.firstWhere((element) => element.id == report.topCountSecond!.keys.elementAt(rank)).packetInfoId!,orElse: ()=>PackageInfo(name: 'removed')).name!;
  }


  String getCount1st(int rank, ReportModel report) {
    return report.topCountFirst!.length < rank + 1 ? ''
        : '${report.topCountFirst![report.topCountFirst!.keys.elementAt(rank)]}';
  }

  String getCount2nd(int rank, ReportModel report) {
    return report.topCountSecond!.length < rank + 1 ? ''
        : '${report.topCountSecond![report.topCountSecond!.keys.elementAt(rank)]}';
  }

  @override
  Widget build(BuildContext context) {
    List<Package>? mPackageList = Provider.of<List<Package>?>(context);
    List<PackageInfo>? pInfoList = Provider.of<List<PackageInfo>?>(context);

    List<ReportModel>? report = context.watch<List<ReportModel>?>();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Management report',
            style: TextStyle(
                color: xColors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.width(5, context)),
          )),
      body:  mPackageList != null && report != null && pInfoList != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Most reserved in ${report[0].id} :',
                            style: TextStyle(
                                color: xColors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.width(5, context)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ManagementWidget(
                            title: 'Semi-annual 1-6',
                            first: getPackage1st(0, mPackageList,pInfoList, report[0]),
                            firstCount: getCount1st(0, report[0]),
                            second: getPackage1st(1, mPackageList,pInfoList, report[0]),
                            secondCount: getCount1st(1, report[0]),
                            third:
                                getPackage1st(2, mPackageList,pInfoList,  report[0]),
                            thirdCount: getCount1st(2, report[0]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ManagementWidget(
                            title: 'Semi-annual 7-12',
                            first:
                                getPackage2nd(0, mPackageList,pInfoList, report[0]),
                            firstCount: getCount2nd(0, report[0]),
                            second:
                                getPackage2nd(1, mPackageList,pInfoList, report[0]),
                            secondCount: getCount2nd(1, report[0]),
                            third:
                                getPackage2nd(2, mPackageList,pInfoList, report[0]),
                            thirdCount: getCount2nd(2, report[0]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        'Date : ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                        style: TextStyle(
                            color: xColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.width(4.5, context))),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          : const Center(child:  Text('error')),
    );
  }
}

class TripRepCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const TripRepCard(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
              fontSize: Responsive.width(4, context),
              fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          icon,
          size: Responsive.width(8, context),
        ),
        shape: Border.all(color: Colors.redAccent, width: 5),
      ),
    );
  }
}
