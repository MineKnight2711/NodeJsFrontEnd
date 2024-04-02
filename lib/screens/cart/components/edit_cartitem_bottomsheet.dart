import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/controller/cart_controller.dart';
import 'package:quanlyquantrasua/model/cart_model.dart';
import 'package:quanlyquantrasua/screens/cart/components/current_chosen_toppings.dart';
import 'package:quanlyquantrasua/screens/product-detail/components/quantity_select.dart';
import 'package:quanlyquantrasua/screens/product-detail/components/size_choices.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/default_button.dart';

import '../../../model/size_model.dart';
import '../../../model/topping_model.dart';

class EditCartItemBottomSheet extends StatefulWidget {
  const EditCartItemBottomSheet({super.key, required this.cartItem});
  final CartItem cartItem;
  @override
  State<EditCartItemBottomSheet> createState() =>
      _EditCartItemBottomSheetState();
}

class _EditCartItemBottomSheetState extends State<EditCartItemBottomSheet> {
  final cartController = Get.find<CartController>();
  late SizeModel selectedSize;
  late int currentQuantity;
  late List<ToppingModel> selectedToppings;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.cartItem.size;
    currentQuantity = widget.cartItem.quantity;
    selectedToppings = List.of(widget.cartItem.toppings);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  '${widget.cartItem.dish.dishName}',
                  style: GoogleFonts.nunito(fontSize: 18),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: GestureDetector(
                      onTap: () {}, child: const Icon(CupertinoIcons.xmark)),
                ))
          ]),
          const Divider(
            thickness: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Text(
                  'Size',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizeRadioChosen(
            item: widget.cartItem.size,
            onSizeSelected: (value) {
              selectedSize = value;
            },
          ),
          const Divider(
            thickness: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Text(
                  'Số lượng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
            child: QuantitySelector(
              initialValue: widget.cartItem.quantity,
              onValueChanged: (value) {
                currentQuantity = value;
              },
            ),
          ),
          const Divider(
            thickness: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Text(
                  'Toppings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          CurrentToppingChoiceWidget(
            onToppingsSelected: (value) {
              selectedToppings = value;
            },
            currentToppings: widget.cartItem.toppings,
          ),
          DefaultButton(
            press: () {
              final updatedItem = widget.cartItem.copyWith(
                size: selectedSize,
                quantity: currentQuantity,
                toppings: selectedToppings,
              );
              cartController.updateCartItem(widget.cartItem, updatedItem);
            },
            text: "Lưu",
          )
        ]),
      ),
    );
  }
}
