import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    return WillPopScope(
      onWillPop: ()async{
        provider.onBackPressed();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            provider.currentTitle(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),
          ),
          leading: provider.pageState !=9?BackButton(onPressed: () {
            provider.onBackPressed();
          }):const SizedBox(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: provider.currentWidget(),
        ),
      ),
    );
  }

}
