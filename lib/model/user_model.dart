class UserModel {
  final String id;
  final String username;
  final String password;
  final List<String> role;
  final bool status;
  final String email;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.status,
    required this.email,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      role: (json['role'] as List<dynamic>).cast<String>(),
      status: json['status'] as bool,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'role': role,
      'status': status,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
