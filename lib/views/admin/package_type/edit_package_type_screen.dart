import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/country_api.dart';

import '../../../models/package_type.dart';
import '../../../server/firebase/package_type_api.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class EditPackageTypeScreen extends StatefulWidget {
  static const routeName = 'edit_country_screen';
  final PackageType? edit;
  final List<PackageType>? all;

  const EditPackageTypeScreen({this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditPackageTypeScreen> createState() => _EditPackageTypeScreenState();
}

class _EditPackageTypeScreenState extends State<EditPackageTypeScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();

  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;

      if (widget.edit == null) {
        await PackageTypeApi().addData(add: PackageType(name: name)).then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await PackageTypeApi()
            .updateData(update: PackageType(id: widget.edit?.id, name: name))
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await PackageTypeApi().deleteData(delete: widget.edit!).then((value) {
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
          widget.edit != null ? 'Edit PackageType' : 'Add PackageType',
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
                                    orElse: () => PackageType(id:null))).id != null)) {
                          return "PackageType Exist";
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
