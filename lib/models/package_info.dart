import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_info.g.dart';

@JsonSerializable()
class PackageInfo {
  String? id;
  String? name;
  String? image;
  double? price;
  String? description;
  String? destinationCityId;
  String? destinationCountryId;
  String? packageTypeId;
  int? daysNum;
  List<String>? planList = []; //length = number of days

  factory PackageInfo.fromJson(var json) => _$PackageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PackageInfoToJson(this);

  PackageInfo({
    this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.destinationCityId,
    this.destinationCountryId,
    this.packageTypeId,
    this.daysNum,
    this.planList,
  });

  List<PackageInfo> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PackageInfo(
        id: doc.get('id'),
        name: doc.get('name'),
        price: doc.get('price'),
        image: doc.get('image'),
        description: doc.get('description'),
        destinationCityId: doc.get('destinationCityId'),
        destinationCountryId: doc.get('destinationCountryId'),
        packageTypeId: doc.get('packageTypeId'),
        daysNum: doc.get('daysNum'),
        planList: (doc.get('planList') as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
      );
    }).toList();
  }

  //to fix the problem of dropdown
  @override
  bool operator ==(dynamic other) =>
      other != null && other is PackageInfo && id == other.id;

  //to fix the problem of dropdown
  @override
  int get hashCode => super.hashCode;


  PackageInfo getPackageInfo(
      {required List<PackageInfo> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => PackageInfo(id: 'null'));
  }
}
