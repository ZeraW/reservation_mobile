import 'package:flutter/material.dart';
import 'package:reservation_mobile/models/package_type.dart';

import '../../../constants/constants.dart';
class PackageTypeRowWidget extends StatelessWidget {
  final PackageType? packageType;
  final Function()? onTap;
  const PackageTypeRowWidget(this.packageType, {this.onTap, Key? key}) : super(key: key);

  Widget getContent(BuildContext context) {
    Widget name = Text(
      packageType!.name!,
      style: const TextStyle(
          fontSize: fontSize15,
          fontWeight: fontWeight400,
          color: blackFontColor
      ),
    );


    Widget padding = Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name,
            const Divider(
              thickness: 1,
            ),
          ],
        ),
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
