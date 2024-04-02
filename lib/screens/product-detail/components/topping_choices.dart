import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/topping/api_topping.dart';

import '../../../model/topping_model.dart';

class ToppingChoiceWidget extends StatefulWidget {
  final void Function(List<ToppingModel>) onToppingsSelected;

  const ToppingChoiceWidget({
    super.key,
    required this.onToppingsSelected,
  });

  @override
  ToppingChoiceWidgetState createState() => ToppingChoiceWidgetState();
}

class ToppingChoiceWidgetState extends State<ToppingChoiceWidget> {
  List<ToppingModel> chosenToppings = [];
  final toppingController = Get.find<ToppingApi>();
  @override
  void initState() {
    super.initState();
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
                itemCount: toppingController.listTopping!.length,
                itemBuilder: (BuildContext context, int index) {
                  final topping = toppingController.listTopping![index];
                  return CheckboxListTile(
                    value: topping.selected,
                    onChanged: (value) {
                      setState(() {
                        topping.selected = value!;
                        if (topping.selected) {
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
                            topping.image != null
                                ? Image.network(
                                    "${topping.image}",
                                    width: 30,
                                  )
                                : const Icon(Icons.category),
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
