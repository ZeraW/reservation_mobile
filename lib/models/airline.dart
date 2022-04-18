import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'airline.g.dart';

@JsonSerializable()
class Airline {
  String? id;
  String? name;
  String? image;
  Airline({
    this.id,
    this.name,
    this.image,
  });


  factory Airline.fromJson(var json) => _$AirlineFromJson(json);

  Map<String, dynamic> toJson() => _$AirlineToJson(this);

  List<Airline> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Airline(
          id: doc.get('id'),
          name: doc.get('name'),
          image: doc.get('image'));
    }).toList();
  }

  Airline getAirline(
      {required List<Airline> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => Airline(id: 'null',name: 'Removed'));
  }

}
