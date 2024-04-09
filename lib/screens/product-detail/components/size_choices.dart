import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';
import 'package:quanlyquantrasua/model/size_model.dart';

class SizeChoiceWidget extends StatelessWidget {
  final Function(SizeModel?) onSelectedSize;

  final _drinkController = Get.find<DrinkController>();
  SizeChoiceWidget({super.key, required this.onSelectedSize});

  @override
  Widget build(BuildContext context) {
    Rx<SizeModel?> selectedSize = Rx<SizeModel?>(null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8.0,
        ),
        Obx(
          () {
            if (_drinkController.listSize.isNotEmpty) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ListView.builder(
                  itemCount: _drinkController.listSize.length,
                  itemExtent: 100,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = _drinkController.listSize[index];
                    return GestureDetector(
                        onTap: () {
                          onSelectedSize(item);
                          selectedSize.value = item;
                        },
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color:
                                  selectedSize.value?.sizeName == item.sizeName
                                      ? Colors.blue
                                      : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(child: Text(item.sizeName!)),
                          ),
                        ));
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}

class SizeRadioChosen extends StatelessWidget {
  final Function(SizeModel) onSelectedSize;
  final SizeModel selected;
  final _drinkController = Get.find<DrinkController>();

  SizeRadioChosen(
      {super.key, required this.onSelectedSize, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_drinkController.listSize.isNotEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height /
              (_drinkController.listSize.length * 1.6),
          width: double.infinity,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _drinkController.listSize.length,
            itemBuilder: (context, index) {
              final item = _drinkController.listSize[index];
              return Column(
                children: [
                  RadioListTile(
                    title: Text(item.sizeName),
                    value: item,
                    groupValue: selected,
                    onChanged: (value) {
                      onSelectedSize(value ?? selected);
                    },
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 15,
                    height: 10,
                  ),
                ],
              );
            },
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  SizeModel getSelected() {
    return selected;
  }
}
