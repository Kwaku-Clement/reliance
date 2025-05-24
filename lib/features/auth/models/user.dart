// lib/features/auth/models/user.dart

class User {
  final String id;
  final String username;
  final String fullName;
  // You might add other user-specific fields here, e.g.,
  // final String email;
  // final String profilePictureUrl;
  // final List<String> roles;

  User({required this.id, required this.username, required this.fullName});

  // Factory constructor to create a User from a JSON map (e.g., from an API response)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );
  }

  // Method to convert a User object to a JSON map (e.g., for sending to an API)
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'fullName': fullName};
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, fullName: $fullName)';
  }
}
