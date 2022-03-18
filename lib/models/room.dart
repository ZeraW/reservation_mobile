import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  String? id;
  String? name;
  String? hotelId;
  String? image;
  String? description;
  double? price;



  factory Room.fromJson(var json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  Room({
    this.id,
    this.name,
    this.hotelId,
    this.image,
    this.description,
    this.price,
  });

  List<Room> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Room(
          id: doc.get('id'),
          image: doc.get('image'),
          description: doc.get('description'),
          price: doc.get('price').toDouble(),
          name: doc.get('name'),hotelId:doc.get('hotelId'));
    }).toList();
  }

}
