import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/city.dart';

class CityRowWidget extends StatelessWidget {
  final City? city;
  final Function()? onTap;
  const CityRowWidget(this.city, {this.onTap, Key? key}) : super(key: key);

  Widget getContent(BuildContext context) {
    Widget name = Text(
      city!.name!,
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