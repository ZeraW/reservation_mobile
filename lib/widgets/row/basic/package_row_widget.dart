import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/package_info.dart';
import '../../../models/package.dart';
import 'package:intl/intl.dart';

class PackageRowWidget extends StatelessWidget {
  final Package? package;
  final PackageInfo? packageInfo;

  final Function()? onTap;
  const PackageRowWidget(this.package, {this.onTap,this.packageInfo, Key? key}) : super(key: key);

  Widget getContent(BuildContext context) {



    Widget padding = Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Package: ${packageInfo!.name!}',
                  style: const TextStyle(
                      fontSize: fontSize15,
                      fontWeight: fontWeight400,
                      color: blackFontColor
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  'id:${package!.id!}',maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: fontSize15,
                      fontWeight: fontWeight400,
                      color: blackFontColor
                  ),
                ),
              ),
              const SizedBox(width: 8,)
            ],
          ),
          const SizedBox(height: 15,),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Depart: ${DateFormat('M/d/yyyy').format(package!.departAt!)}\n\n'
                      'Return: ${DateFormat('M/d/yyyy').format(package!.returnAt!)}',
                  style: const TextStyle(
                      fontSize: fontSize15,
                      fontWeight: fontWeight400,
                      color: blackFontColor
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Capacity: ${package!.capacity!}\n\n'
                      'Remaining: ${package!.remaining!}',
                  style: const TextStyle(
                      fontSize: fontSize15,
                      fontWeight: fontWeight400,
                      color: blackFontColor
                  ),
                ),
              ),
            ],
          ),
         const SizedBox(height: 5,),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: padding,
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }
}
