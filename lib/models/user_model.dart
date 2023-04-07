// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String profile;
  String userId;
//  String gender;
  String phone;

  UserModel({
    required this.name,
    required this.profile,
    required this.userId,
    required this.phone,
  });

  UserModel copyWith({
    String? name,
    String? profile,
    String? userId,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      profile: profile ?? this.profile,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profile': profile,
      'userId': userId,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profile: map['profile'] as String,
      userId: map['userId'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, profile: $profile, userId: $userId, phone: $phone)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.profile == profile &&
      other.userId == userId &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      profile.hashCode ^
      userId.hashCode ^
      phone.hashCode;
  }
}
