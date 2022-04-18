import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reservation_mobile/models/room.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  String? id;
  String? name;
  String? desc;

  double? rate;
  String? image;
  String? cityId;
  String? countryId;
  Map<String, String>? keyWords;

  factory Hotel.fromJson(var json) => _$HotelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelToJson(this);
  Hotel({
    this.id,
    this.name,
    this.rate,this.desc,
    this.image,
    this.cityId,
    this.countryId,
    this.keyWords
  });

  List<Hotel> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Hotel(
          id: doc.get('id'),
          name: doc.get('name'),
          desc: doc.get('desc'),
          cityId: doc.get('cityId'),
          countryId: doc.get('countryId'),
          image: doc.get('image'),
          keyWords: doc.get('keyWords') != null
              ? Map<String, String>.from(doc.get('keyWords'))
              : {},
          rate: doc.get('rate').toDouble());
    }).toList();
  }


  Hotel getHotel(
      {required List<Hotel> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => Hotel(id: 'null',name: 'Removed'));
  }
}
