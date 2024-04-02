class CategoryModel {
  int? id;
  String? categoryName;
  String? image;

  CategoryModel({
    this.id,
    this.categoryName,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['categoryID'],
      categoryName: json['categoryName'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryID': id,
      'categoryName': categoryName,
      'image': image,
    };
  }
}
