import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/topping/api_topping.dart';
import '../../../model/topping_model.dart';

class CurrentToppingChoiceWidget extends StatefulWidget {
  final Function(List<ToppingModel>) onToppingsSelected;
  final List<ToppingModel>? currentToppings;

  const CurrentToppingChoiceWidget({
    Key? key,
    required this.onToppingsSelected,
    this.currentToppings,
  }) : super(key: key);

  @override
  CurrentToppingChoiceWidgetState createState() =>
      CurrentToppingChoiceWidgetState();
}

class CurrentToppingChoiceWidgetState
    extends State<CurrentToppingChoiceWidget> {
  List<ToppingModel> chosenToppings = [];
  final toppingController = Get.find<ToppingApi>();

  @override
  void initState() {
    super.initState();
    chosenToppings = widget.currentToppings ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          if (toppingController.listTopping != null) ...[
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: toppingController.listTopping!.length,
                itemBuilder: (BuildContext context, int index) {
                  final topping = toppingController.listTopping![index];
                  return CheckboxListTile(
                    value: chosenToppings.contains(topping),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          chosenToppings.add(topping);
                        } else {
                          chosenToppings.remove(topping);
                        }
                      });
                      widget.onToppingsSelected(chosenToppings);
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${topping.toppingName}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Image.network(
                              "${topping.image}",
                              width: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$${topping.price?.toStringAsFixed(2)} / ${topping.unit}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
