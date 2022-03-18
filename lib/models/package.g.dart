// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: json['id'] as String?,
      packetInfoId: json['packetInfoId'] as String?,
      departAt: json['departAt'] == null
          ? null
          : DateTime.parse(json['departAt'] as String),
      returnAt: json['returnAt'] == null
          ? null
          : DateTime.parse(json['returnAt'] as String),
      capacity: json['capacity'] as int?,
      remaining: json['remaining'] as int?,
      keyWords: json['keyWords'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'packetInfoId': instance.packetInfoId,
      'departAt': instance.departAt,
      'returnAt': instance.returnAt,
      'capacity': instance.capacity,
      'remaining': instance.remaining,
      'keyWords': instance.keyWords,
    };
