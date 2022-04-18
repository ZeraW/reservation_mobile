import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'flight_type.g.dart';

@JsonSerializable()
class FlightType {
  String? id;
  String? name;
  double? price;



  factory FlightType.fromJson(var json) => _$FlightTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FlightTypeToJson(this);

  FlightType({
    this.id,
    this.name,
    this.price,
  });

  List<FlightType> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FlightType(
          id: doc.get('id'),
          name: doc.get('name'),
          price: doc.get('price').toDouble());
    }).toList();
  }

  FlightType getFlightType(
      {required List<FlightType> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => FlightType(id: 'null',name: 'Removed'));
  }

}
