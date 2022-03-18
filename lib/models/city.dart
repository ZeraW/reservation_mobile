import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservation_mobile/models/country.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  String? id;
  String? name;
  String? countryId;

  //to fix the problem of dropdown
  @override
  bool operator ==(dynamic other) =>
      other != null && other is City && id == other.id;
  //to fix the problem of dropdown
  @override
  int get hashCode => super.hashCode;

  factory City.fromJson(var json) =>
      _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  List<City> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return City(
          id: doc.get('id'),
          name: doc.get('name'),countryId:doc.get('countryId'));
    }).toList();
  }

  City({
    this.id,
    this.name,
    this.countryId,
  });
}
