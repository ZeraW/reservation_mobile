// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightType _$FlightTypeFromJson(Map<String, dynamic> json) => FlightType(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FlightTypeToJson(FlightType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
