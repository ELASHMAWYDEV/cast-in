import 'dart:convert';

import 'package:cast_in/utils/app_enums.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? city;
  final String? bio;
  final String? profession;
  final int? age;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final DateTime? createdAt;
  final UserType? userType;

  UserModel({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.phoneNumber,
    this.country,
    this.city,
    this.bio,
    this.profession,
    this.age,
    this.profileImageUrl,
    this.coverImageUrl,
    this.createdAt,
    this.userType,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['full_name'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      country: map['country'],
      city: map['city'],
      bio: map['bio'],
      profession: map['profession'],
      age: map['age'],
      profileImageUrl: map['profile_image_url'],
      coverImageUrl: map['cover_image_url'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      userType: map['user_type'] != null
          ? UserType.values.firstWhere(
              (type) => type.toString() == 'UserType.${map['user_type']}',
              orElse: () => UserType.client,
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'country': country,
      'city': city,
      'bio': bio,
      'profession': profession,
      'age': age,
      'profile_image_url': profileImageUrl,
      'cover_image_url': coverImageUrl,
      'created_at': createdAt?.toIso8601String(),
      'user_type': userType?.toString().split('.').last,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    String? bio,
    String? profession,
    int? age,
    String? profileImageUrl,
    String? coverImageUrl,
    DateTime? createdAt,
    UserType? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      city: city ?? this.city,
      bio: bio ?? this.bio,
      profession: profession ?? this.profession,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdAt: createdAt ?? this.createdAt,
      userType: userType ?? this.userType,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, username: $username, email: $email, phoneNumber: $phoneNumber, country: $country, city: $city, bio: $bio, profession: $profession, age: $age, profileImageUrl: $profileImageUrl, coverImageUrl: $coverImageUrl, createdAt: $createdAt, userType: $userType)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.username == username &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.country == country &&
        other.city == city &&
        other.bio == bio &&
        other.profession == profession &&
        other.age == age &&
        other.profileImageUrl == profileImageUrl &&
        other.coverImageUrl == coverImageUrl &&
        other.createdAt == createdAt &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        country.hashCode ^
        city.hashCode ^
        bio.hashCode ^
        profession.hashCode ^
        age.hashCode ^
        profileImageUrl.hashCode ^
        coverImageUrl.hashCode ^
        createdAt.hashCode ^
        userType.hashCode;
  }
}
