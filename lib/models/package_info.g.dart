// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageInfo _$PackageInfoFromJson(Map<String, dynamic> json) => PackageInfo(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      destinationCityId: json['destinationCityId'] as String?,
      destinationCountryId: json['destinationCountryId'] as String?,
      packageTypeId: json['packageTypeId'] as String?,
      daysNum: json['daysNum'] as int?,
      planList: (json['planList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PackageInfoToJson(PackageInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'description': instance.description,
      'destinationCityId': instance.destinationCityId,
      'destinationCountryId': instance.destinationCountryId,
      'packageTypeId': instance.packageTypeId,
      'daysNum': instance.daysNum,
      'planList': instance.planList,
    };
