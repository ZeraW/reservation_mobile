import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';

import '../../../models/flight_type.dart';
import '../../../server/firebase/flight_type_api.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class EditFlightTypeScreen extends StatefulWidget {
  static const routeName = 'edit_flightType_screen';
  final FlightType? edit;
  final List<FlightType>? all;

  const EditFlightTypeScreen({this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditFlightTypeScreen> createState() => _EditFlightTypeScreenState();
}

class _EditFlightTypeScreenState extends State<EditFlightTypeScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController priceTEC = TextEditingController();


  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;
      double price =  double.parse(priceTEC.text);

      if (widget.edit == null) {
        await FlightTypeApi().addData(add: FlightType(name: name,price: price)).then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await FlightTypeApi()
            .updateData(update: FlightType(id: widget.edit?.id, name: name,price: price))
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await FlightTypeApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit != null) {
      nameTEC.text = widget.edit!.name!;
      priceTEC.text = widget.edit!.price!.toString();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit != null ? 'Edit FlightType' : 'Add FlightType',
          style: const TextStyle(
            color: blackFontColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormBuilder(
                      hint: "name",
                      controller: nameTEC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a valid name";
                        } else if (((widget.all!.firstWhere(
                                    (it) =>
                                        it.name!.toLowerCase() ==
                                        value.toLowerCase(),
                                    orElse: () => FlightType(id:null))).id != null)) {
                          return "FlightType Exist";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormBuilder(
                      hint: "price",
                      controller: priceTEC,
                      keyType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            const Text('save'),
                            isExpanded: true,
                            color: mainGColor,
                            fun: () {
                              save();
                            },
                          ),
                        ),
                        widget.edit != null
                            ? Expanded(
                                child: ButtonWidget(
                                  const Text(
                                    'delete',
                                    style: TextStyle(color: whiteFontColor),
                                  ),
                                  isExpanded: true,
                                  color: mainRColor,
                                  fun: () {
                                    delete();
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
