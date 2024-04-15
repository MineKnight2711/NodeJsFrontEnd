import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';
import 'package:quanlyquantrasua/controller/order_controller.dart';
import 'package:quanlyquantrasua/model/cart_model.dart';
import 'package:quanlyquantrasua/screens/cart/components/edit_cartitem_bottomsheet.dart';
import 'package:quanlyquantrasua/screens/cart/components/edit_cartitem_button.dart';
import 'package:quanlyquantrasua/utils/format_currency.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import '../../controller/cart_controller.dart';
import '../../widgets/custom_widgets/default_button.dart';
import '../../widgets/custom_widgets/messages_widget.dart';
import '../../widgets/custom_widgets/showLoading.dart';

class CartScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();
  final drinkController = Get.find<DrinkController>();
  final userController = Get.find<AccountController>();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'Giỏ hàng của tôi',
        appBarBackgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (cartController.listCart.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.listCart.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = cartController.listCart[index];
                    return Dismissible(
                      key: Key(item.hashCode.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        cartController.deleteCartItem(item.id);
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 5.h),
                        leading: SizedBox(
                          height: size.height / 10,
                          width: size.width / 4,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 1,
                                right: 85,
                                child: Obx(
                                  () => Checkbox(
                                    value: cartController.checkedItems.any(
                                        (checkedItem) =>
                                            checkedItem.id == item.id),
                                    onChanged: (value) {
                                      if (value ?? false) {
                                        cartController.checkedItems.add(item);
                                      } else {
                                        cartController.checkedItems.removeWhere(
                                            (checkedItem) =>
                                                checkedItem.id == item.id);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: SizedBox(
                                    height: size.height / 10,
                                    width: size.width / 7,
                                    child: Image.network(
                                      item.drink.imageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "${item.quantity}x ${item.drink.drinkName} - ",
                                style: const TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: item.size.sizeName,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        trailing: Column(
                          children: [
                            Obx(
                              () => EditCartItemButton(
                                isEnabled: !cartController.checkedItems.any(
                                    (checkedItem) => checkedItem.id == item.id),
                                onTap: () {
                                  drinkController.getByDrinkId(item.drink.id);
                                  DraggableScrollableSheet(
                                    builder: (context, scrollController) =>
                                        EditCartItemBottomSheet(cartItem: item),
                                  );
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (context) {
                                      return DraggableScrollableSheet(
                                        expand: false,
                                        initialChildSize: 0.8,
                                        minChildSize: 0.7,
                                        maxChildSize: 0.9,
                                        builder: (context, scrollController) =>
                                            EditCartItemBottomSheet(
                                                cartItem: item),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Obx(
                              () => Text(
                                  ' ${formatCurrency(calculateItemTotal(item).value)}'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2)),
              child: const Center(
                child: Icon(
                  Icons.local_mall_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            const Text(
              "Giỏ hàng của bạn rỗng\nKhi bạn thêm sản phẩm,\n chúng sẽ xuất hiện ở đây",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  height: 1.2,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5),
            )
          ]),
        );
      }),
      bottomNavigationBar: Obx(
        () => CartBottomNavigation(
            onPaymentPressed: () async {
              if (cartController.checkedItems.isEmpty) {
                CustomErrorMessage.showMessage(
                    'Bạn phải chọn ít nhất 1 sản phẩm để đặt hàng');
                return;
              }
              showLoadingAnimation(context);
              // Logger().i(
              //     '${userController.accountRespone.value?.accountId ?? 0} +  loggg user');
              // Logger()
              //     .i('${cartController.checkedItem.length} + log cart choose');
              final result = await OrderController.saveOrder(
                  user: userController.userSession.value?.id ?? '',
                  orderItems: convertToOrderItems(cartController.checkedItems));
              if (result.success) {
                CustomToastMessage.showMessage("Đặt hàng thành công");
                cartController
                    .deleteCarts(cartController.checkedItems
                        .map((element) => element.id)
                        .toList())
                    .whenComplete(() => cartController.getByUserId());
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              } else {
                CustomErrorMessage.showMessage("Có lỗi xảy ra");
              }
            },
            totalPrice: cartController.checkedItems.fold(
                0.0,
                (preValue, cart) =>
                    preValue += calculateItemTotal(cart).value)),
      ),
    );
  }

  List<OrderItem> convertToOrderItems(List<CartModel> checkedItems) {
    List<OrderItem> orderItems = [];
    for (var cartModel in checkedItems) {
      OrderItem orderItem = OrderItem(
        cartItem: cartModel.id, // Assuming id is the reference to the cart item
        quantity: cartModel.quantity,
      );
      orderItems.add(orderItem);
    }
    return orderItems;
  }

  RxDouble calculateItemTotal(CartModel item) {
    double basePrice = item.quantity * item.drink.price;
    double sizeTotal = item.quantity * item.size.price;
    double toppingTotal = item.toppings.fold(
      0.0,
      (total, topping) => total + (topping.price ?? 0.0),
    );
    return (basePrice + toppingTotal + sizeTotal).obs;
  }
}

class CartBottomNavigation extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onPaymentPressed;

  CartBottomNavigation(
      {super.key, required this.totalPrice, required this.onPaymentPressed});
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Color.fromARGB(255, 210, 217, 221)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tổng cộng: ${formatCurrency(totalPrice)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: mediaHeight(context, 18),
              width: mediaWidth(context, 3),
              child: DefaultButton(text: 'Thanh toán', press: onPaymentPressed))
        ],
      ),
    );
  }
}
