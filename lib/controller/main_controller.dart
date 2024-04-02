import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/category_controller.dart';

class MainController {
  static initializeControllers() {
    Get.put(CategoryController());
  }
}
