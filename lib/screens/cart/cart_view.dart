import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:quanlyquantrasua/api/account/account_api.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/screens/cart/components/edit_cartitem_bottomsheet.dart';
import 'package:quanlyquantrasua/screens/cart/components/edit_cartitem_button.dart';
import 'package:quanlyquantrasua/utils/format_currency.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/messages_widget.dart';
import '../../controller/cart_controller.dart';
import '../../controller/order_controller.dart';
import '../../widgets/custom_widgets/default_button.dart';
import '../../widgets/custom_widgets/showLoading.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final cartController = Get.find<CartController>();
  final orderController = Get.put(CreateOrderController());
  final userController = Get.find<AccountApi>();

  @override
  void initState() {
    super.initState();
  }

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
        if (cartController.cartItem.isNotEmpty) {
          final listItem = cartController.cartItem;
          var checkedItemFromList = cartController.checkedItem;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: checkedItemFromList.length == listItem.length
                            ? checkedItemFromList.isNotEmpty
                            : cartController.isCheckAll,
                        onChanged: (value) {
                          setState(() {
                            cartController.isCheckAll = value ?? false;
                            cartController.checkAll();
                          });
                        },
                      ),
                      const Text('Chọn tất cả'),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: size.width / 2.8,
                    height: size.height / 24,
                    margin: const EdgeInsets.only(right: 10),
                    child: DefaultButton(
                      enabled: cartController.isCheckAll,
                      press: () {
                        cartController.clearCart();
                      },
                      text: 'Xoá giỏ hàng',
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listItem[index];
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
                        setState(() {
                          cartController.removeItem(item);
                        });
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
                                child: Checkbox(
                                  value: cartController
                                              .queryChekedItemList(item) !=
                                          -1
                                      ? true
                                      : cartController.isCheckAll,
                                  onChanged: (value) {
                                    setState(() {
                                      cartController.isCheckAll = false;
                                      cartController.checkPerItem(item);
                                    });
                                  },
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
                                      "${item.dish.image}",
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
                                    "${item.quantity}x ${item.dish.dishName} - ",
                                style: const TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "${item.size.sizeName}",
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text("${item.dish.categories?.categoryName}"),
                        trailing: Column(
                          children: [
                            EditCartItemButton(
                              isEnabled:
                                  cartController.queryChekedItemList(item) ==
                                      -1,
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
                            Text(
                                ' ${formatCurrency(cartController.calculateItemTotal(item))}'),
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
              if (cartController.checkedItem.isEmpty) {
                CustomErrorMessage.showMessage(
                    'Bạn phải chọn ít nhất 1 sản phẩm để đặt hàng');
                return;
              }
              showLoadingAnimation(context);
              Logger().i(
                  '${userController.accountRespone.value?.accountId ?? 0} +  loggg user');
              Logger()
                  .i('${cartController.checkedItem.length} + log cart choose');
              orderController.createOrder(
                  userController.accountRespone.value?.accountId ?? 0,
                  cartController.checkedItem);
              cartController.removeCheckedItemsFromCart();
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
            totalPrice: cartController.totalPrice.value),
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
