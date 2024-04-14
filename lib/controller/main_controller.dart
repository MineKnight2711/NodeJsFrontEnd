import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/topping/api_topping.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/category_controller.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';

class MainController {
  static initializeControllers() {
    Get.put(AccountController());
    Get.put(CategoryController());
    Get.put(DrinkController());
    Get.put(ToppingApi());
  }
}
