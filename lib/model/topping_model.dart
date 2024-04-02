class ToppingModel {
  int? toppingID;
  String? unit;
  String? image;
  double? price;
  String? toppingName;
  bool selected;

  ToppingModel({
    this.toppingID,
    this.unit,
    this.image,
    this.price,
    this.toppingName,
    this.selected = false,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      toppingID: json['toppingID'],
      unit: json['unit'],
      image: json['image'],
      price: json['price'],
      toppingName: json['toppingName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'toppingID': toppingID,
      'unit': unit,
      'image': image,
      'price': price,
      'toppingName': toppingName,
    };
  }
}
