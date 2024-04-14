class CategoryModel {
  String? id;
  String? categoryName;
  String? imageUrl;
  bool? isDelete;

  CategoryModel({
    this.id,
    this.categoryName,
    this.imageUrl,
    this.isDelete,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
      isDelete: json['isDelete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'isDelete': isDelete,
    };
  }
}
