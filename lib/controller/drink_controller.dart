import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/product/api_drink.dart';
import 'package:quanlyquantrasua/api/size/api_size.dart';
import 'package:quanlyquantrasua/model/drink_model.dart';
import '../model/size_model.dart';

class DrinkController extends GetxController {
  late DrinkApi _drinkApi;
  late SizeApi _sizeApi;
  RxList<DrinkModel> listDrink = <DrinkModel>[].obs;
  RxList<DrinkModel> listSearchDrink = <DrinkModel>[].obs;
  RxList<DrinkModel> listDrinkByCategoryId = <DrinkModel>[].obs;
  RxList<SizeModel> listSize = <SizeModel>[].obs;
  Rx<DrinkModel?> currentDrink = Rx<DrinkModel?>(null);
  @override
  void onInit() {
    super.onInit();
    _drinkApi = DrinkApi();
    _sizeApi = SizeApi();
    getAllDrink();
    getAllSize();
  }

  // Future<String> getAllDrinkTopping(String drinkId) async {
  //   try {
  //     final response = await _toppingApi.getByDrinkId(drinkId);
  //     final listJson = response.data as List<dynamic>;
  //     // print(listJson.length);
  //     listSize.value =
  //         listJson.map((item) => SizeModel.fromJson(item)).toList();
  //     return "Success";
  //   } catch (e) {
  //     return "Fail";
  //   }
  // }

  Future<String> getAllSize() async {
    try {
      final response = await _sizeApi.getAllSize();
      final listJson = response.data as List<dynamic>;
      // print(listJson.length);
      listSize.value =
          listJson.map((item) => SizeModel.fromJson(item)).toList();
      return "Success";
    } catch (e) {
      return "Fail";
    }
  }

  Future<String> getAllDrink() async {
    try {
      final response = await _drinkApi.getAllDish();
      final listJson = response.data as List<dynamic>;
      // print(listJson.length);
      listDrink.value =
          listJson.map((item) => DrinkModel.fromJson(item)).toList();
      return "Success";
    } catch (e) {
      return "Fail";
    }
  }

  Future<String> getByDrinkId(String drinkApi) async {
    try {
      final response = await _drinkApi.getByDrinkId(drinkApi);
      currentDrink.value = DrinkModel.fromJson(response.data);
      return "Success";
    } catch (e) {
      return "Fail";
    }
  }

  Future<List<DrinkModel>> getByCategoryId(String id) async {
    try {
      final response = await _drinkApi.getByCategoryId(id);
      final listJson = response.data as List<dynamic>;

      return listJson.map((e) => DrinkModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception("Có lỗi xảy ra");
    }
  }

  Future<void> searchDish(String q) async {
    try {
      final response = await _drinkApi.search(q);
      final listJson = response.data as List<dynamic>;
      listSearchDrink.value =
          listJson.map((e) => DrinkModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception("Có lỗi xảy ra");
    }
  }
}
