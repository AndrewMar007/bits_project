import '../../domain/entities/user_entity.dart';

class UserModel implements User {
  @override
  String? id;
  @override
  String? email;
  @override
  String? password;
  @override
  String? login;

  UserModel({
    this.id,
    this.email,
    this.password,
    this.login,
  });

  @override
  bool operator ==(Object other) {
    return other is UserModel &&
        other.email == email &&
        other.password == password &&
        other.id == id &&
        other.login == login;
  }

  @override
  int get hashCode => email.hashCode;

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json!['_id'],
      email: json['email'],
      password: json['password'],
      login: json['nickName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'nickName': login,
    };
  }
}
