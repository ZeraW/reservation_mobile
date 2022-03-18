import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:intl/intl.dart';

import '../../../models/package.dart';
import '../../../models/package_info.dart';
import '../../../server/firebase/package_api.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/date_time_picker.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/textfield_widget.dart';

class EditPackageScreen extends StatefulWidget {
  static const routeName = 'edit_hotel_screen';
  final Package? edit;
  final List<Package>? all;

  const EditPackageScreen({this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditPackageScreen> createState() => _EditPackageScreenState();
}

class _EditPackageScreenState extends State<EditPackageScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController capacityTEC = TextEditingController();
  final TextEditingController departAtTEC = TextEditingController();
  final TextEditingController returnAtTEC = TextEditingController();
  Map<String, dynamic> keyWords = {};

  int remaining = 0;
  DateTime? departAt =DateTime.now();
  DateTime? returnAt=DateTime.now();

  PackageInfo? selectedPInfo;

  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      createSearchKeywordsList();
      int capacity = int.parse(capacityTEC.text);

      if (widget.edit == null) {
        await PackageApi()
            .addData(
                add: Package(
          capacity: capacity,
          remaining: remaining,
          departAt: departAt,
          returnAt: returnAt,
          packetInfoId: selectedPInfo!.id!,
          keyWords: keyWords,
        ))
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await PackageApi()
            .updateData(
                update: Package(
          id: widget.edit?.id,
          capacity: capacity,
          remaining: remaining,
          departAt: departAt,
          returnAt: returnAt,
          packetInfoId: selectedPInfo == null
              ? widget.edit!.packetInfoId
              : selectedPInfo!.id!,
          keyWords: keyWords,
        ))
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void createSearchKeywordsList() {
    keyWords.clear();
    keyWords['pInfo'] = selectedPInfo!.id;
    keyWords['name'] = selectedPInfo!.name;
    keyWords['city'] = selectedPInfo!.destinationCityId;
    keyWords['country'] = selectedPInfo!.destinationCountryId;
    keyWords['price'] = selectedPInfo!.price;
    keyWords['days'] = selectedPInfo!.daysNum;
    keyWords['departAt'] = departAt;
    keyWords['returnAt'] = returnAt;
    keyWords['returnAt'] = returnAt;

    debugPrint(keyWords.toString());
  }

  void delete() async {
    await PackageApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit != null) {
      capacityTEC.text = widget.edit!.capacity!.toString();
      departAt = widget.edit!.departAt;
      returnAt = widget.edit!.returnAt;
      remaining = widget.edit!.remaining!;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PackageInfo>? listPInfo = context.watch<List<PackageInfo>?>();

    if (listPInfo != null && selectedPInfo == null && widget.edit != null) {
      selectedPInfo = listPInfo.firstWhere(
          (element) => element.id == widget.edit?.packetInfoId,
          orElse: () => PackageInfo(id: 'null', name: 'Removed'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit != null ? 'Edit Package' : 'Add Package',
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
                    const SizedBox(
                      height: 5,
                    ),
                    listPInfo != null
                        ? DropDownBuilder(
                            list: listPInfo,
                            errorText: 'Select Package Info',
                            selectedItem: selectedPInfo,
                            hint: "Package Info",
                            onChange: (value) {
                              setState(() {
                                selectedPInfo = value;
                                returnAt = departAt!.add(Duration(days: selectedPInfo!.daysNum!));
                                returnAtTEC.text = DateFormat('M/d/yyyy hh:mm:ss').format(returnAt!);
                              });
                            })
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormBuilder(
                      hint: "capacity",
                      controller: capacityTEC,
                      keyType: TextInputType.number,
                      onChange: (s) {
                        if (s != null) {
                          int cA = int.parse(s);
                          remaining = widget.edit != null
                              ? remaining + widget.edit!.remaining!
                              : cA;
                          setState(() {});
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter capacity";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('remaining: $remaining')),
                    const SizedBox(
                      height: 20,
                    ),
                    DateTimePickerBuilder(
                      hint: "Depart At",
                      controller: departAtTEC,
                      onChange: (date) {
                        setState(() {
                          departAt = date;
                          if(selectedPInfo!=null){
                            returnAt = date!.add( Duration(days: selectedPInfo!.daysNum!));
                            returnAtTEC.text = DateFormat('M/d/yyyy hh:mm:ss').format(returnAt!);

                          }

                          setState(() {

                          });

                        });
                      },
                      validator: (value) {
                        if (returnAt != null && value!.isAfter(returnAt!)) {
                          return "depart at can't be after return at";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DateTimePickerBuilder(
                      hint: "Return At",
                      controller: returnAtTEC,
                      currentDate: returnAt,
                      enabled: false,
                      validator: (value) {
                        if (departAt != null && value!.isBefore(departAt!)) {
                          return "return at can't be before depart at";
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
