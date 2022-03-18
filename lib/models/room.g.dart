// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      id: json['id'] as String?,
      name: json['name'] as String?,
      hotelId: json['hotelId'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hotelId': instance.hotelId,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
    };
