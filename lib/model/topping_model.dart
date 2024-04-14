class ToppingModel {
  String id;
  String? imageUrl;
  double? price;
  String? toppingName;
  bool selected;

  ToppingModel({
    required this.id,
    this.imageUrl,
    this.price,
    this.toppingName,
    this.selected = false,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      toppingName: json['toppingName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'unit': unit,
      'imageUrl': imageUrl,
      'price': price,
      'toppingName': toppingName,
    };
  }
}
