import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/screens/cart/components/edit_cartitem_bottomsheet.dart';
import 'package:quanlyquantrasua/screens/cart/components/edit_cartitem_button.dart';
import 'package:quanlyquantrasua/utils/format_currency.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import '../../controller/cart_controller.dart';
import '../../widgets/custom_widgets/default_button.dart';

class CartScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();

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
                                    width: size.width / 5.5,
                                    child: Image.network(
                                      "${item.drink.imageUrl}",
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
                                text: "${item.size.sizeName}",
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text("${item.drink.category.categoryName}"),
                        trailing: Column(
                          children: [
                            Obx(
                              () => EditCartItemButton(
                                isEnabled: cartController.checkedItems.any(
                                    (checkedItem) => checkedItem.id == item.id),
                                onTap: () {
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
                                    builder: (BuildContext context) {
                                      return EditCartItemBottomSheet(
                                          cartItem: item);
                                    },
                                  );
                                },
                              ),
                            ),
                            Text(
                                ' ${formatCurrency(item.quantity * item.drink.price)}'),
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
              // if (cartController.checkedItem.isEmpty) {
              //   CustomErrorMessage.showMessage(
              //       'Bạn phải chọn ít nhất 1 sản phẩm để đặt hàng');
              //   return;
              // }
              // showLoadingAnimation(context);
              // Logger().i(
              //     '${userController.accountRespone.value?.accountId ?? 0} +  loggg user');
              // Logger()
              //     .i('${cartController.checkedItem.length} + log cart choose');
              // orderController.createOrder(
              //     userController.accountRespone.value?.accountId ?? 0,
              //     cartController.checkedItem);
              // cartController.removeCheckedItemsFromCart();
              // Future.delayed(const Duration(seconds: 2), () {
              //   Navigator.pop(context);
              //   Navigator.pop(context);
              // });
            },
            totalPrice: cartController.checkedItems
                .fold(0.0, (preValue, cart) => preValue += cart.drink.price)),
      ),
    );
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
    return BottomAppBar(
      elevation: 4.0,
      child: Container(
        height: mediaHeight(context, 12),
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
                child:
                    DefaultButton(text: 'Thanh toán', press: onPaymentPressed))
          ],
        ),
      ),
    );
  }
}
