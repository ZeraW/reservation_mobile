// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      desc: json['desc'] as String?,
      image: json['image'] as String?,
      cityId: json['cityId'] as String?,
      countryId: json['countryId'] as String?,
      keyWords: (json['keyWords'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'rate': instance.rate,
      'image': instance.image,
      'cityId': instance.cityId,
      'countryId': instance.countryId,
      'keyWords': instance.keyWords,
    };
