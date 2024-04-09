// ignore_for_file: non_constant_identifier_names

class SizeModel {
  String sizeID;
  String sizeName;
  double price;
  SizeModel({
    required this.sizeID,
    required this.sizeName,
    required this.price,
  });
  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      sizeID: json['_id'],
      sizeName: json['sizeName'],
      price: json['price'].toDouble(),
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
