// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: json['id'] as String?,
      packageId: json['packageId'] as String?,
      userId: json['userId'] as String?,
      capacity: json['capacity'] as int?,
      departAt: json['departAt'] as int?,
      returnAt: json['returnAt'] as int?,
      canceled: json['canceled'] as bool?,
      airLineId: json['airLineId'] as String?,
      flightTypeId: json['flightTypeId'] as String?,
      hotelId: json['hotelId'] as String?,
      roomsAndCount: (json['roomsAndCount'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      packagePrice: (json['packagePrice'] as num?)?.toDouble(),
      flightPrice: (json['flightPrice'] as num?)?.toDouble(),
      hotelPrice: (json['hotelPrice'] as num?)?.toDouble(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'userId': instance.userId,
      'canceled': instance.canceled,
      'capacity': instance.capacity,
      'airLineId': instance.airLineId,
      'departAt': instance.departAt,
      'returnAt': instance.returnAt,
      'flightTypeId': instance.flightTypeId,
      'hotelId': instance.hotelId,
      'roomsAndCount': instance.roomsAndCount,
      'packagePrice': instance.packagePrice,
      'flightPrice': instance.flightPrice,
      'hotelPrice': instance.hotelPrice,
      'totalPrice': instance.totalPrice,
    };
