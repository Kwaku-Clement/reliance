import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String? profilePictureUrl;
  final List<String> roles;
  final String? address;
  final String? gender;
  final DateTime? dob;

  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    this.profilePictureUrl,
    this.roles = const [],
    this.address,
    this.gender,
    this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      roles: (json['roles'] as List<dynamic>?)?.cast<String>() ?? [],
      address: json['address'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] != null ? DateTime.parse(json['dob'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profilePictureUrl': profilePictureUrl,
      'roles': roles,
      'address': address,
      'gender': gender,
      'dob': dob?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? username,
    String? fullName,
    String? email,
    String? phone,
    String? profilePictureUrl,
    List<String>? roles,
    String? address,
    String? gender,
    DateTime? dob,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      roles: roles ?? this.roles,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
    );
  }

  @override
  List<Object?> get props => [
    id,
    username,
    fullName,
    email,
    phone,
    profilePictureUrl,
    roles,
    address,
    gender,
    dob,
  ];

  @override
  String toString() {
    return 'User(id: $id, username: $username, fullName: $fullName, email: $email, phone: $phone, gender: $gender, dob: $dob, roles: $roles, address: $address, profilePictureUrl: $profilePictureUrl)';
  }
}
