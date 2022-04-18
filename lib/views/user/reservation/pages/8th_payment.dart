import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/flight_type.dart';
import 'package:reservation_mobile/models/hotel.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_info.dart';
import 'package:reservation_mobile/models/room.dart';
import 'package:reservation_mobile/provider/reservation_provider.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';
import 'package:reservation_mobile/server/firebase/reservation_api.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';
import 'package:reservation_mobile/widgets/textfield_widget.dart';

class ResPayment extends StatelessWidget {
  ResPayment({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController cardTEC = TextEditingController();
  final TextEditingController dateTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationManage>();
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Total Cost',
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
                          Text(
                              'Package Price: ${provider.reservation.packagePrice} L.E'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Flight Price: ${provider.reservation.flightPrice} L.E'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Hotel Price: ${provider.reservation.hotelPrice} L.E'),
                          const Divider(
                            color: Colors.black,
                          ),
                          Text(
                              'Total Price: ${provider.reservation.totalPrice} L.E'),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormBuilder(
                    hint: "Name",
                    controller: nameTEC,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormBuilder(
                    hint: "Card Number",
                    controller: cardTEC,
                    keyType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormBuilder(
                    hint: "Expired At",
                    controller: dateTEC,
                    keyType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          ButtonWidget(
            const Text(
              'Continue',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            isExpanded: true,
            color: xColors.mainColor,
            fun: () async {
              final form = formKey.currentState;
              if (form!.validate()) {
                await ReservationApi()
                    .addData(add: provider.reservation)
                    .then((value) async{

                      await PackageApi().updateCount(count: -provider.reservation.capacity!, docId: provider.reservation.packageId);
                  provider.goTo(9);
                });
              } else {}
            },
          ),
        ],
      ),
    );
  }
}
