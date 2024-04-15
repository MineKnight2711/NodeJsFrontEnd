import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/category/api_category.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  late CategoryApi _categoryApi;
  RxList<CategoryModel> listCategory = <CategoryModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _categoryApi = CategoryApi();
    getAllCategory();
  }

  Future<String> getAllCategory() async {
    final response = await _categoryApi.getAllCategory();
    if (response.success) {
      final responseJson = response.data as List<dynamic>;
      listCategory.value =
          responseJson.map((json) => CategoryModel.fromJson(json)).toList();
      return "Success";
    }
    return "Fail";
  }
}
