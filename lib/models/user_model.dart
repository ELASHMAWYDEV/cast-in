import 'dart:convert';

import 'package:cast_in/utils/app_enums.dart';

class UserModel {
  final String id;
  final String phoneNumber;
  final String? fullName;
  final String? username;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? height;
  final String? country;
  final String? city;
  final String? bio;
  final String? hairColor;
  final String? hairStyle;
  final String? eyeColor;
  final int? weightInKg;
  final DateTime? updatedAt;
  final DateTime createdAt;
  final UserType userType;

  UserModel({
    required this.id,
    required this.phoneNumber,
    this.fullName,
    this.username,
    this.dateOfBirth,
    this.gender,
    this.height,
    this.country,
    this.city,
    this.bio,
    this.hairColor,
    this.hairStyle,
    this.eyeColor,
    this.weightInKg,
    this.updatedAt,
    required this.createdAt,
    required this.userType,
  });

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? fullName,
    String? username,
    DateTime? dateOfBirth,
    String? gender,
    String? height,
    String? country,
    String? city,
    String? bio,
    String? hairColor,
    String? hairStyle,
    String? eyeColor,
    int? weightInKg,
    DateTime? updatedAt,
    DateTime? createdAt,
    UserType? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      country: country ?? this.country,
      city: city ?? this.city,
      bio: bio ?? this.bio,
      hairColor: hairColor ?? this.hairColor,
      hairStyle: hairStyle ?? this.hairStyle,
      eyeColor: eyeColor ?? this.eyeColor,
      weightInKg: weightInKg ?? this.weightInKg,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone_number': phoneNumber,
      'full_name': fullName,
      'username': username,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'height': height,
      'country': country,
      'city': city,
      'bio': bio,
      'hair_color': hairColor,
      'hair_style': hairStyle,
      'eye_color': eyeColor,
      'weight_in_kg': weightInKg,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'user_type': userType.toString(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      phoneNumber: map['phone_number'] as String,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      dateOfBirth: map['date_of_birth'] != null ? DateTime.parse(map['date_of_birth'] as String) : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      hairColor: map['hair_color'] != null ? map['hair_color'] as String : null,
      hairStyle: map['hair_style'] != null ? map['hair_style'] as String : null,
      eyeColor: map['eye_color'] != null ? map['eye_color'] as String : null,
      weightInKg: map['weight_in_kg'] != null ? map['weight_in_kg'] as int : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      userType: UserType.values.firstWhere((e) => e.toString() == map['user_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, username: $username, dateOfBirth: $dateOfBirth, gender: $gender, height: $height, country: $country, city: $city, bio: $bio, hairColor: $hairColor, hairStyle: $hairStyle, eyeColor: $eyeColor, weightInKg: $weightInKg, updatedAt: $updatedAt, createdAt: $createdAt, userType: $userType)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.fullName == fullName &&
        other.username == username &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.height == height &&
        other.country == country &&
        other.city == city &&
        other.bio == bio &&
        other.hairColor == hairColor &&
        other.hairStyle == hairStyle &&
        other.eyeColor == eyeColor &&
        other.weightInKg == weightInKg &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phoneNumber.hashCode ^
        fullName.hashCode ^
        username.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        country.hashCode ^
        city.hashCode ^
        bio.hashCode ^
        hairColor.hashCode ^
        hairStyle.hashCode ^
        eyeColor.hashCode ^
        weightInKg.hashCode ^
        updatedAt.hashCode ^
        createdAt.hashCode ^
        userType.hashCode;
  }
}
