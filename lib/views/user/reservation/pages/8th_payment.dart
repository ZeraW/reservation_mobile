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
import 'package:flutter_credit_card/flutter_credit_card.dart';

class ResPayment extends StatefulWidget {
  ResPayment({Key? key}) : super(key: key);

  @override
  State<ResPayment> createState() => _ResPaymentState();
}

class _ResPaymentState extends State<ResPayment> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final TextEditingController nameTEC = TextEditingController();
    String name = '';
   String card = '';
   String date = '';
  String ccv = '';

  final TextEditingController cardTEC = TextEditingController();
  final TextEditingController ccvTEC = TextEditingController();

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
                  CreditCardWidget(
                    cardNumber: card,
                    expiryDate: date,
                    cardHolderName: name,
                    cvvCode: ccv,
                    showBackView: false, onCreditCardWidgetChange: (CreditCardBrand ) {  }, //true when you want to show cvv(back) view
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormBuilder(
                    hint: "Name",
                    controller: nameTEC,
                    onChange: (k){
                      setState(() {
                        name = k!;
                      });
                    },

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
                    maxLength: 16,
                    keyType: TextInputType.number,
                    onChange: (k){
                      setState(() {
                        card = k!;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormBuilder(
                          hint: "Expired At",
                          controller: dateTEC,
                          keyType: TextInputType.datetime,
                          maxLength: 5,
                          onChange: (k){
                            setState(() {
                              date = k!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },

                        ),
                      ),
                      const SizedBox(width: 20,),

                      Expanded(
                        child: TextFormBuilder(
                          hint: "CCV",
                          controller: ccvTEC,
                          maxLength: 3,
                          keyType: TextInputType.number,
                          onChange: (k){
                            setState(() {
                              ccv = k!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
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
