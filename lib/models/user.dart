import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? userType;




  factory UserModel.fromJson(var json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.userType,
  });


  List<UserModel> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
          id: doc.get('id'),
          name: doc.get('name'),
          phone: doc.get('phone'),
          email: doc.get('email'),
          password: doc.get('password'),
          userType: doc.get('userType'));
    }).toList();
  }


  String getUserName({required List<UserModel> list, required String id}) {
    return list
        .firstWhere((element) => element.id == id,
        orElse: () => UserModel(id: 'null', name: 'Removed'))
        .name!;
  }

}
