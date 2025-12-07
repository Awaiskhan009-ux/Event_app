
import 'package:my_events_2025/domain/entities/user_entity.dart';



class UserModel extends UserEntity {
  UserModel({required super.token, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // ReqRes API token aur email alag deta hai, hum adjust kar rahe hain
      token: json['token'] ?? '',
      email: json['email'] ?? 'user@example.com',
    );
  }
}