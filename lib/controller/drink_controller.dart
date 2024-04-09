import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/product/api_drink.dart';
import 'package:quanlyquantrasua/api/size/api_size.dart';
import 'package:quanlyquantrasua/model/drink_model.dart';

import '../model/size_model.dart';

class DrinkController extends GetxController {
  late DrinkApi _drinkApi;
  late SizeApi _sizeApi;
  RxList<DrinkModel> listDrink = <DrinkModel>[].obs;
  RxList<SizeModel> listSize = <SizeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _drinkApi = DrinkApi();
    _sizeApi = SizeApi();
    getAllDrink();
    getAllSize();
  }

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
}
