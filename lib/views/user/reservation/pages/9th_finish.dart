
import 'package:flutter/material.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';

class ResFinish extends StatelessWidget {
  const ResFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      const   Text(
        'Reservation Done\nSuccessfully',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
         textAlign: TextAlign.center,
      ),
      const   SizedBox(height: 20,),
      const   Icon(Icons.check_circle_outline,size: 50,),
      const   SizedBox(height: 20,),
      ButtonWidget(
        const  Text(
          'BACK TO HOME',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        isExpanded: true,
        color: Colors.black,
        fun: () {
          NavigationService.userInstance.pushReplacement('user_home');

        },
      ),
      const   SizedBox(height: 20,),
    ],);
  }
}