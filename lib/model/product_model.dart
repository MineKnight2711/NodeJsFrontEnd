class Product {
  int? dishid;
  String? dishname;
  String? image;
  double? price;
  int? categoryid;
  int? sizeid;

  Product({
    this.dishid,
    this.dishname,
    this.image,
    this.price,
    this.categoryid,
    this.sizeid,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      dishid: json['dishid'] as int,
      dishname: json['dishname'] as String,
      image: json['image'] as String,
      price: json['price'] as double,
      categoryid: json['categoryid'] as int,
      sizeid: json['sizeid'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dishid': dishid,
      'dishname': dishname,
      'image': image,
      'price': price,
      'categoryid': categoryid,
      'sizeid': sizeid,
    };
  }
}
