import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/utils/data_convert.dart';

import '../../../model/topping_model.dart';

class CurrentToppingChoiceWidget extends StatelessWidget {
  final RxList<ToppingModel> chosenToppings = <ToppingModel>[].obs;
  final Function(List<ToppingModel>) onToppingsSelected;
  final List<ToppingModel> currentToppings;
  final List<ToppingModel> drinkTopping;

  CurrentToppingChoiceWidget({
    super.key,
    required this.onToppingsSelected,
    required this.currentToppings,
    required this.drinkTopping,
  });

  @override
  Widget build(BuildContext context) {
    chosenToppings.value = currentToppings;
    return SizedBox(
      height: 200.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          if (drinkTopping.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: drinkTopping.length,
                itemBuilder: (BuildContext context, int index) {
                  final topping = drinkTopping[index];
                  return Obx(
                    () => CheckboxListTile(
                      value: chosenToppings
                          .any((element) => element.id == topping.id),
                      onChanged: (value) {
                        if (value!) {
                          chosenToppings.add(topping);
                        } else {
                          chosenToppings.removeWhere(
                              (element) => element.id == topping.id);
                        }
                        onToppingsSelected(chosenToppings);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${topping.toppingName}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Image.network(
                                "${topping.imageUrl}",
                                width: 30,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DataConvert.formatCurrency(topping.price ?? 0),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
