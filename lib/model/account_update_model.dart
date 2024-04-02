class AccountUpdate {
  int? accountId;
  String? fullName;
  String? phoneNumber;
  DateTime? birthday;
  String? address;
  String? imageUrl;
  AccountUpdate(
      {this.accountId,
      this.fullName,
      this.phoneNumber,
      this.imageUrl,
      this.birthday,
      this.address});

  AccountUpdate.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
    phoneNumber = json['phoneNumber'];
    birthday = json['birthday'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['imageUrl'] = imageUrl;
    data['birthday'] = birthday;
    data['address'] = address;
    return data;
  }
}
