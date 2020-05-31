import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String name;
  String uid;
  String email;
  String profileImage;
  bool isAdmin;
  String token;

  User({this.name, this.uid, this.email, this.profileImage, this.isAdmin, this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}