// ignore_for_file: non_constant_identifier_names

class SizeModel {
  int? sizeID;
  String? sizeName;
  double? price;
  SizeModel({
    this.sizeID,
    this.sizeName,
    this.price,
  });
  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      sizeID: json['sizeID'],
      sizeName: json['sizeName'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sizeID': sizeID,
      'sizeName': sizeName,
      'price': price,
    };
  }
}
