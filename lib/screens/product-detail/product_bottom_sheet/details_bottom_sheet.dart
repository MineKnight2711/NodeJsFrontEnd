// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/cart_controller.dart';
import 'package:quanlyquantrasua/model/drink_model.dart';
import 'package:quanlyquantrasua/model/size_model.dart';
import 'package:quanlyquantrasua/model/topping_model.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/default_button.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/messages_widget.dart';
import 'package:scroll_edge_listener/scroll_edge_listener.dart';

import '../../../widgets/custom_widgets/showLoading.dart';
import '../components/size_choices.dart';
import '../components/topping_choices.dart';

class OrderDetailsBottomSheet extends StatefulWidget {
  final DrinkModel drink;
  const OrderDetailsBottomSheet({required this.drink, Key? key})
      : super(key: key);
  @override
  OrderDetailsBottomSheetState createState() => OrderDetailsBottomSheetState();
}

class OrderDetailsBottomSheetState extends State<OrderDetailsBottomSheet> {
  final cartControler = Get.find<CartController>();
  final accountController = Get.find<AccountController>();
  SizeModel? selectedSize;
  int numOfItem = 0;
  List<ToppingModel>? listChosenTopping;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.91,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.aspectRatio * 20),
                  child: Center(
                    child: Text(
                      widget.drink.drinkName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollEdgeListener(
              edge: ScrollEdge.start,
              edgeOffset: 0,
              continuous: false,
              dispatch: true,
              listener: () {
                //Đóng bottom sheet khi người dùng kéo hết cạnh trên của nó
                //Hoạt động không như mong đợi vì 1 số lỗi
                // Navigator.pop(context);
              },
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Image.network(widget.drink.imageUrl),
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        height: size.height / 14,
                        width: size.width,
                        child: StyledGradienButton(
                          onPressed: () async {
                            if (selectedSize == null) {
                              CustomErrorMessage.showMessage(
                                  'Bạn chưa chọn kích cỡ!');
                              return;
                            }
                            if (accountController.userSession.value == null) {
                              CustomErrorMessage.showMessage(
                                  'Vui lòng đăng nhập để đặt hàng!');
                              return;
                            }
                            showLoadingAnimation(context);
                            final result = await cartControler.addToCart(
                                accountController.userSession.value!.id,
                                widget.drink.id,
                                selectedSize!.id);
                            if (result.success) {
                              CustomToastMessage.showMessage(
                                  "Đã thêm vào giỏ hàng");
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            } else {
                              CustomToastMessage.showMessage(result.data);
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                            }
                          },
                          buttonText: 'Thêm vào giỏ',
                          buttonIconAssets: 'assets/images/cart_add.png',
                        ),
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Chọn kích cỡ',
                                  style: GoogleFonts.nunito(fontSize: 16),
                                ),
                              ],
                            ),
                            SizeChoiceWidget(
                              onSelectedSize: (size) {
                                selectedSize = size;
                                print(selectedSize?.sizeName);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              'Thêm topping',
                              style: GoogleFonts.nunito(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      ToppingChoiceWidget(
                        listTopping: widget.drink.toppings,
                        onToppingsSelected: (selectedToppings) {
                          listChosenTopping = selectedToppings;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
