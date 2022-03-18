import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';

import 'package:reservation_mobile/models/hotel.dart';

class HotelRowWidget extends StatelessWidget {
  final Hotel? hotel;
  final Function()? onTap;
  const HotelRowWidget(this.hotel, {this.onTap, Key? key}) : super(key: key);

  Widget getContent(BuildContext context) {
    Widget name = Text(
      hotel!.name!,
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
            Row(
              children: [
                Image.network(hotel!.image??'https://firebasestorage.googleapis.com/v0/b/reservation-7f6b8.appspot.com/o/holder.jpg?alt=media&token=a87e51f9-ab72-4e69-9112-b54c7bc7da6a',width: 60,height: 60,fit: BoxFit.cover),
                const SizedBox(width: 15,),
                name,
              ],
            ),
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
