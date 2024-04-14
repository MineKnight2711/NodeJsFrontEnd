class UserModel {
  final String id;
  final String username;
  final List<String> role;
  final bool status;
  final String email;
  final String imageUrl;
  final String gender;
  final String address;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.username,
    required this.role,
    required this.status,
    required this.email,
    required this.imageUrl,
    required this.gender,
    required this.address,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
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
      'role': role,
      'status': status,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'address': address,
    };
  }
}
