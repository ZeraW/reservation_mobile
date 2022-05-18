import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {

  String? id;
  String? packetInfoId;
  DateTime? departAt;
  DateTime? returnAt;
  int? capacity;
  int? remaining;
  Map<String, dynamic>? keyWords;


  Package({
    this.id,
    this.packetInfoId,
    this.departAt,
    this.returnAt,
    this.capacity,
    this.remaining,
    this.keyWords
  });




  factory Package.fromJson(var json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);

  List<Package> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Package(
          id: doc.get('id'),
          packetInfoId: doc.get('packetInfoId'),
          departAt: doc.get('departAt').toDate(),
          returnAt: doc.get('returnAt').toDate(),
          capacity: doc.get('capacity'),
          remaining: doc.get('remaining'),
          keyWords: doc.get('keyWords') != null
              ? Map<String, dynamic>.from(doc.get('keyWords'))
              : {});
    }).toList();
  }

  Package getPackage(
      {required List<Package> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => Package(id: 'null',keyWords: {'name':'Removed'}));
  }

}
