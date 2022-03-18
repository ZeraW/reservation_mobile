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
}
