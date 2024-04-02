import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quanlyquantrasua/api/order/api_order.dart';
import 'package:quanlyquantrasua/model/cart_model.dart';

class CreateOrderController extends GetxController {
  var list = <DishOrder>[].obs;

  get getCartChoose => list;

  Future createOrder(int userId, List<CartItem> listChoose) async {
    if (listChoose.isEmpty) return;

    var listTemp = <DishOrder>[];
    var listTopping = <ToppingOrder>[];
    for (var i = 0; i < listChoose.length; i++) {
      var temp = DishOrder();
      temp.dishId = listChoose[i].dish.dishID;
      temp.quantity = listChoose[i].quantity;
      temp.sizeId = listChoose[i].size.sizeID;
      Logger().i('${temp.sizeId} log sizeId');
      for (var j = 0; j < listChoose[i].toppings.length; j++) {
        Logger().i('${listChoose[i].toppings.length} + log quantity Topping');
        var topping = ToppingOrder();
        topping.toppingId = listChoose[i].toppings[j].toppingID;
        Logger().i(topping.toppingId);
        listTopping.add(topping);
      }
      temp.listTopping = listTopping;
      listTemp.add(temp);
    }
    list.value = listTemp;
    await FetchApiOrderService.createOrder(userId, list);
    listChoose.clear();
    return;
  }
}
