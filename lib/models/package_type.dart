import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_type.g.dart';

@JsonSerializable()
class PackageType {
  String? id;
  String? name;

  factory PackageType.fromJson(var json) => _$PackageTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PackageTypeToJson(this);

  PackageType({
    this.id,
    this.name,
  });

  List<PackageType> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PackageType(
          id: doc.get('id'),
          name: doc.get('name'));
    }).toList();
  }


  //to fix the problem of dropdown
  @override
  bool operator ==(dynamic other) =>
      other != null && other is PackageType && id == other.id;
  //to fix the problem of dropdown
  @override
  int get hashCode => super.hashCode;

  String getPackageTypeName(
      {required List<PackageType> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => PackageType(id: 'null', name: 'Removed'))
        .name!;
  }
}
