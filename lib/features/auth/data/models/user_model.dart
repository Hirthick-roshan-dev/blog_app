import 'package:blog_app/features/auth/domain/entities/user.dart';

class UserModel  {
  final String id;
  final String name;
  final String email;

  UserModel({required this.name, required this.email, required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        id: json["id"] ?? ""
    );
  }

  User toEntity(){
    return User(name: name, email: email, id: id);
  }
}
