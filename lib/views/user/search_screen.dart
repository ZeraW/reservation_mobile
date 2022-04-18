import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reservation_mobile/models/city.dart';
import 'package:reservation_mobile/models/country.dart';
import 'package:reservation_mobile/models/package.dart';
import 'package:reservation_mobile/models/package_type.dart';
import 'package:reservation_mobile/navigation_service.dart';
import 'package:reservation_mobile/provider/search_provider.dart';
import 'package:reservation_mobile/server/firebase/city_api.dart';
import 'package:reservation_mobile/server/firebase/package_api.dart';
import 'package:reservation_mobile/utils/colors.dart';
import 'package:reservation_mobile/views/user/search_result.dart';
import 'package:reservation_mobile/widgets/button/button_widget.dart';
import 'package:reservation_mobile/widgets/date_time_picker.dart';
import 'package:reservation_mobile/widgets/drop_down.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Country? selectedCountry;

  City? selectedCity;

  PackageType? selectedType;
  DateTime? departAt = DateTime.now();
  final TextEditingController departAtTEC = TextEditingController();

  RangeValues priceRange = const RangeValues(0, 5000);

  @override
  Widget build(BuildContext context) {
    List<Country>? listCountry = context.watch<List<Country>?>();
    List<City>? listCity = context.watch<List<City>?>();
    List<PackageType>? listPackageType = context.watch<List<PackageType>?>();

    return FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DateTimePickerBuilder(
                hint: "Date",
                controller: departAtTEC,
                inputType: InputType.date,
                firstDate: DateTime.now(),
                onChange: (date) {
                  setState(() {
                    departAt = date;
                    setState(() {});
                  });
                },
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              listPackageType != null
                  ? DropDownBuilder(
                      list: listPackageType,
                      errorText: '',
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
              listCountry != null
                  ? DropDownBuilder(
                      list: listCountry,
                      errorText: '',
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
                                errorText: '',
                                selectedItem: selectedCity,
                                hint: "City",
                                onChange: (value) {
                                  selectedCity = value;
                                  setState(() {});
                                })
                            : const SizedBox();
                      })
                  : const SizedBox(),
              selectedCountry != null
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(),
              const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Price')),
              RangeSlider(
                values: priceRange,
                min: 0,
                max: 5000,
                divisions: 10,
                activeColor: Colors.black87,
                labels: RangeLabels(
                    '${priceRange.start == 5000 ? '∞' : priceRange.start.toInt()}',
                    '${priceRange.end == 5000 ? '∞' : priceRange.end.toInt()}'),
                onChanged: (value) {
                  setState(() {
                    priceRange = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                const Text('Search'),
                isExpanded: true,
                color: xColors.mainColor,
                fun: () {
                  NavigationService.userInstance.navigateToWidget(
                      StreamBuilder<List<Package>>(
                          stream: PackageApi().query(
                              pType: selectedType?.id,
                              city: selectedCity?.id,
                              country: selectedCountry?.id,
                              price1: priceRange.start == 5000
                                  ? null
                                  : priceRange.start.toInt(),
                              price2: priceRange.end == 5000
                                  ? null
                                  : priceRange.end.toInt()),
                          builder: (context, snapshot) {
                            List<Package>? pList = snapshot.data;
                            List<Package>? filteredList;
                            pList != null
                                ? filteredList = pList
                                    .where((i) =>
                                DateTime(i.departAt!.year,i.departAt!.month,i.departAt!.day).millisecondsSinceEpoch >=
                                    DateTime(departAt!.year,departAt!.month,departAt!.day).millisecondsSinceEpoch)
                                    .toList()
                                : filteredList = null;

                            filteredList?.sort((a,b) => a.departAt!.millisecondsSinceEpoch.compareTo(b.departAt!.millisecondsSinceEpoch));

                            return filteredList != null
                                ? ChangeNotifierProvider(
                                    create: (context) => SearchManage(
                                        date: departAt!,
                                        priceRange: priceRange,
                                        pList: filteredList!),
                                    child: const SearchResult())
                                : const SizedBox();
                          }));
                },
              ),
            ],
          ),
        ));
  }
}
