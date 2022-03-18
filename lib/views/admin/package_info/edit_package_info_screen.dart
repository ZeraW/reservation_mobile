import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/constants/constants.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/package_type.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/server/firebase/city_api.dart';
import '../../../models/city.dart';
import '../../../models/package_info.dart';
import '../../../server/firebase/package_info_api.dart';
import '../../../widgets/add_pic.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/textfield_widget.dart';

class EditPackageInfoScreen extends StatefulWidget {
  static const routeName = 'edit_hotel_screen';
  final PackageInfo? edit;
  final List<PackageInfo>? all;

  const EditPackageInfoScreen({this.edit, this.all, Key? key}) : super(key: key);

  @override
  State<EditPackageInfoScreen> createState() => _EditPackageInfoScreenState();
}


class _EditPackageInfoScreenState extends State<EditPackageInfoScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController priceTEC = TextEditingController();
  final TextEditingController descTEC = TextEditingController();
  final TextEditingController daysTEC = TextEditingController();
  List<String>? planList = []; //length = number of days
  List<TextEditingController>? planTECList = [];
  File? _storedImage;



  Country? selectedCountry ;
  City? selectedCity;
  PackageType? selectedType;


  void save() async {

    final form = formKey.currentState;
    if (form!.validate()) {
      String name = nameTEC.text;
      double price = double.parse(priceTEC.text);
      String desc = descTEC.text;
      int days = int.parse(daysTEC.text);

      if (widget.edit == null) {
        await PackageInfoApi().addData(add: PackageInfo(name: name,price: price,description: desc,
          destinationCountryId: selectedCountry!.id!,
          destinationCityId: selectedCity!.id!,
          daysNum: days,
          packageTypeId: selectedType!.id!,
          planList: planTECList!.map((e) => e.text.toString()).toList()

        ),file:_storedImage).then((value) {
          NavigationService.adminInstance.goBack();
        });
      } else {
        await PackageInfoApi().updateData(
            update: PackageInfo(id: widget.edit?.id, name: name,description: desc,price: price,
          destinationCountryId: selectedCountry==null ? widget.edit!.destinationCountryId :selectedCountry!.id! ,
          destinationCityId: selectedCity==null ? widget.edit!.destinationCityId :selectedCity!.id! ,
          packageTypeId: selectedType==null ? widget.edit!.packageTypeId :selectedType!.id! ,
          planList: planTECList!.map((e) => e.text.toString()).toList(),
          image: widget.edit?.image,
          daysNum: days,
        ),file:_storedImage).then((value) {
          NavigationService.adminInstance.goBack();
        });
      }
    } else {
      debugPrint('Form is invalid');
    }
  }

  void delete() async {
    await PackageInfoApi().deleteData(delete: widget.edit!).then((value) {
      NavigationService.adminInstance.goBack();
    });
  }



  @override
  void initState() {
    super.initState();
    if (widget.edit != null) {
      nameTEC.text = widget.edit!.name!;
      priceTEC.text = widget.edit!.price!.toString();
      descTEC.text = widget.edit!.description!;
      daysTEC.text = widget.edit!.daysNum!.toString();

    }
  }

  @override
  Widget build(BuildContext context) {

    List<Country>? listCountry = context.watch<List<Country>?>();
    List<City>? listCity = context.watch<List<City>?>();
    List<PackageType>? listPackageType = context.watch<List<PackageType>?>();


    if (listCountry != null && selectedCountry == null && widget.edit!=null) {
      selectedCountry = listCountry.firstWhere(
              (element) => element.id == widget.edit?.destinationCountryId,
          orElse: () => Country(id: 'null', name: 'Removed'));
    }
    if (listCity != null && selectedCity == null&& widget.edit!=null) {
      selectedCity = listCity.firstWhere(
              (element) => element.id == widget.edit?.destinationCityId,
          orElse: () => City(id: 'null', name: 'Removed'));
    }
    if (listPackageType != null && selectedType == null&& widget.edit!=null) {
      selectedType = listPackageType.firstWhere(
              (element) => element.id == widget.edit?.packageTypeId,
          orElse: () => PackageType(id: 'null', name: 'Removed'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.edit != null ? 'Edit Package Info' : 'Add Package Info',
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

                    listPackageType != null
                        ? DropDownBuilder(
                        list: listPackageType,
                        errorText: 'Select Package type',
                        selectedItem: selectedType,
                        hint: "Package type",
                        onChange: (value) {
                          setState(() {
                            selectedType = value;
                            //  selectedCity = null;
                          });
                        })
                        : const SizedBox(),

                    const SizedBox(
                      height: 20,
                    ),

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
                    TextFormBuilder(
                      hint: "num. of days",
                      controller: daysTEC,
                      keyType: TextInputType.number,
                      onSubmitted: (s){
                        planTECList!.clear();
                        setState(() {

                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter num. of days";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    daysTEC.text.isNotEmpty ?
                    const Align(alignment: AlignmentDirectional.centerStart,child: Text('Plans')):const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: int.parse(daysTEC.text.isNotEmpty ? daysTEC.text :'0'),
                        itemBuilder: (context,index){
                          planTECList?.add(TextEditingController(text:

                          '${ //to keep the old plans in case we added more days
                              widget.edit!=null?
                              index < widget.edit!.planList!.length ? widget.edit!.planList![index] :index+1
                                  :index+1
                          }'));

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormBuilder(
                              hint: "Day ${index+1} Plan",
                              controller: planTECList![index],
                              maxLines: 2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter day ${index+1} Plan";
                                }
                                return null;
                              },
                            ),
                          );
                        }),


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
