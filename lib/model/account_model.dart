import 'package:intl/intl.dart';

class Accounts {
  int? id;
  String? username;
  String? password;
  DateTime? birthday;
  String? email;
  String? gender;
  String? phoneNumber;
  String? address;
  String? imageUrl;
  int? accounttypeid;

  Accounts(
      {this.id,
      this.imageUrl,
      this.password,
      this.birthday,
      this.gender,
      this.username,
      this.email,
      this.phoneNumber,
      this.address,
      this.accounttypeid});

  factory Accounts.fromJson(Map<String, dynamic> json) {
    return Accounts(
      id: json['accountId'] as int,
      imageUrl: json['imageUrl'],
      username: json['fullName'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      password: json['password'] as String,
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      accounttypeid: int.parse(json['accountTypeId'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    String birthdayDate =
        DateFormat('dd/MM/yyyy').format(birthday ?? DateTime.now());
    return {
      'fullName': username,
      'imageUrl': imageUrl,
      'password': password,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'birthday': birthdayDate,
      'address': address,
      'accountTypeId': accounttypeid,
    };
  }

  Map<String, dynamic> loginToJson() {
    return {
      'username': email,
      'password': password,
    };
  }
}
