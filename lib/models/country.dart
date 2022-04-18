import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  String? id;
  String? name;
  factory Country.fromJson(var json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  Country({
    this.id,
    this.name,
  });


  List<Country> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Country(
          id: doc.get('id'),
          name: doc.get('name'));
    }).toList();
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Country && id == other.id;

  @override
  int get hashCode => super.hashCode;



  String getCountryName({required List<Country> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => Country(id: 'null', name: 'Removed'))
        .name!;
  }
}
