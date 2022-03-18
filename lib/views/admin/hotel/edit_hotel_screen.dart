import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/city_api.dart';
import 'package:reservation_mobile/server/firebase/country_api.dart';

import '../../../models/city.dart';
import '../../../models/hotel.dart';
import '../../../server/firebase/hotel_api.dart';
import '../../../widgets/add_pic.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/textfield_widget.dart';

class EditHotelScreen extends StatefulWidget {
  static const routeName = 'edit_hotel_screen';
  final Hotel? edit;
  final List<Hotel>? all;

  const EditHotelScreen({this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditHotelScreen> createState() => _EditHotelScreenState();
}

class _EditHotelScreenState extends State<EditHotelScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController rateTEC = TextEditingController();
  final TextEditingController descTEC = TextEditingController();
  File? _storedImage;

  Country? selectedCountry ;
  City? selectedCity;

  void save() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;
      double rate = double.parse(rateTEC.text);
      String desc = descTEC.text;

      if (widget.edit == null) {
        await HotelApi().addData(add: Hotel(name: name,rate: rate,desc: desc,
          countryId: selectedCountry!.id!,
          cityId: selectedCity!.id!,
          keyWords: {'countryId':selectedCountry!.id!,'cityId':selectedCity!.id!}

        ),file:_storedImage).then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await HotelApi()
            .updateData(update: Hotel(id: widget.edit?.id, name: name,desc: desc,rate: rate,
          countryId: selectedCountry==null ? widget.edit!.countryId :selectedCountry!.id! ,
          cityId: selectedCity==null ? widget.edit!.cityId :selectedCity!.id! ,
            keyWords: {'countryId': selectedCountry==null ? widget.edit!.countryId! :selectedCountry!.id! ,
              'cityId':selectedCity==null ? widget.edit!.cityId! :selectedCity!.id!},
              image: widget.edit?.image

        ),file:_storedImage)
            .then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await HotelApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit != null) {
      nameTEC.text = widget.edit!.name!;
      rateTEC.text = widget.edit!.rate!.toString();
      descTEC.text = widget.edit!.desc!;

    }
  }

  @override
  Widget build(BuildContext context) {

    List<Country>? listCountry = context.watch<List<Country>?>();
    List<City>? listCity = context.watch<List<City>?>();

    if (listCountry != null && selectedCountry == null && widget.edit!=null) {
      selectedCountry = listCountry.firstWhere(
              (element) => element.id == widget.edit?.countryId,
          orElse: () => Country(id: 'null', name: 'Removed'));
    }
    if (listCity != null && selectedCity == null&& widget.edit!=null) {
      selectedCity = listCity.firstWhere(
              (element) => element.id == widget.edit?.cityId,
          orElse: () => City(id: 'null', name: 'Removed'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit != null ? 'Edit Hotel' : 'Add Hotel',
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
                        } else if (!value.contains(RegExp('^[a-zA-Z]+\$'))) {
                          return "Use only letters from a-z";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormBuilder(
                      hint: "rate",
                      controller: rateTEC,
                      keyType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a valid rate";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    listCountry != null
                        ? DropDownBuilder(
                        list: listCountry,
                        errorText: 'Select Country',
                        selectedItem: selectedCountry,
                        hint: "Country",
                        onChange: (value) {
                          setState(() {
                            selectedCountry = value;
                          //  selectedCity = null;
                          });
                        })
                        : const SizedBox(),

                    const SizedBox(
                      height: 20,
                    ),
                    selectedCountry != null
                        ? StreamBuilder<List<City>?>(
                        stream: CityApi().getLiveData(selectedCountry!.id!),
                        builder: (context, snapshot) {
                          List<City>? mCityList = snapshot.data;

                          return mCityList != null
                              ? DropDownBuilder(
                              list: mCityList,
                              errorText: 'Select City',
                              selectedItem: selectedCity,
                              hint: "City",
                              onChange: (value) {
                                selectedCity = value;
                                setState(() {
                                });
                              })
                              : const SizedBox();
                        })
                        : const SizedBox(),
                    selectedCountry != null
                        ? const SizedBox(
                      height: 20,
                    ) : const SizedBox(),

                    TextFormBuilder(
                      hint: "description",
                      controller: descTEC,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a description";
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
