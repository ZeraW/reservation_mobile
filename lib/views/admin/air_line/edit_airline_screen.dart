import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/airline.dart';
import 'package:reservation_mobile/navigation_service.dart';
import '../../../server/firebase/airline_api.dart';
import '../../../widgets/add_pic.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class EditAirLineScreen extends StatefulWidget {
  static const routeName = 'edit_airLine_screen';
  final Airline? edit;
  final List<Airline>? all;

  const EditAirLineScreen({this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditAirLineScreen> createState() => _EditAirLineScreenState();
}

class _EditAirLineScreenState extends State<EditAirLineScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  File? _storedImage;

  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;

      if (widget.edit == null) {
        await AirlineApi().addData(add: Airline(name: name),file:_storedImage).then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await AirlineApi()
            .updateData(update: Airline(id: widget.edit?.id, name: name, image: widget.edit?.image),file:_storedImage)
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await AirlineApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.edit != null) {
      nameTEC.text = widget.edit!.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit != null ? 'Edit Airline' : 'Add Airline',
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
                    AddPic(
                        onChange: (f) {
                          _storedImage = f;
                          setState(() {});
                        },
                        imageUrl:
                            widget.edit != null && widget.edit!.image != null
                                ? widget.edit!.image
                                : null),
                    const SizedBox(
                      height: 20,
                    ),
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
                                orElse: () => Airline(id: null))).id !=
                            null)) {
                          return "AirLine Exist";
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
