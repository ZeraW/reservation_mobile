import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';

import '../../../models/city.dart';
import '../../../server/firebase/city_api.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class EditCityScreen extends StatefulWidget {
  static const routeName = 'edit_country_screen';
  final City? edit;
  final List<City>? all;
  final String countryId;

  const EditCityScreen({required this.countryId,this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditCityScreen> createState() => _EditCityScreenState();
}

class _EditCityScreenState extends State<EditCityScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();

  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;

      if (widget.edit == null) {
        await CityApi().addData(add: City(name: name,countryId: widget.countryId)).then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await CityApi()
            .updateData(update: City(id: widget.edit?.id,countryId: widget.countryId, name: name))
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await CityApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
          widget.edit != null ? 'Edit City' : 'Add City',
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
                        }  else if (((widget.all!.firstWhere(
                                    (it) =>
                                        it.name!.toLowerCase() ==
                                        value.toLowerCase(),
                                    orElse: () => City(id:null))).id != null)) {
                          return "City Exist";
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
