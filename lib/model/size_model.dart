// ignore_for_file: non_constant_identifier_names

class SizeModel {
  final String id;
  final String sizeName;
  final double price;

  SizeModel({
    required this.id,
    required this.sizeName,
    required this.price,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      id: json['_id'],
      sizeName: json['sizeName'],
      price: json['price'].toDouble(),
    );
  }
}
