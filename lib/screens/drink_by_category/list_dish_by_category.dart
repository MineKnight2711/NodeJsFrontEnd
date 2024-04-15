import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';
import 'package:quanlyquantrasua/model/category_model.dart';
import 'package:quanlyquantrasua/model/drink_model.dart';

import 'package:quanlyquantrasua/utils/format_currency.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_input_textformfield.dart';

import '../../../../utils/normalize_vietnamese_string.dart';
import '../product-detail/product_bottom_sheet/details_bottom_sheet.dart';

//enum theo sau là một tập hợp các giá trị hằng số được đặt trong dấu ngoặc nhọn {}
enum SortBy { priceLowToHigh, priceHighToLow }

class DishByCategory extends StatefulWidget {
  final CategoryModel category;

  const DishByCategory({super.key, required this.category});
  @override
  DishByCategoryState createState() => DishByCategoryState();
}

class DishByCategoryState extends State<DishByCategory> {
  List<DrinkModel> _dishes = [];
  List<DrinkModel> _filteredDishes = [];
  TextEditingController searchController = TextEditingController();
  final categoryController = Get.find<DrinkController>();
  SortBy _sortBy = SortBy.priceLowToHigh;
  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  Future<void> loadDishes() async {
    List<DrinkModel>? dishes =
        await categoryController.getByCategoryId(widget.category.id ?? "");
    setState(() {
      _dishes = dishes;
      _filteredDishes = dishes;
    });
  }

  void sortDishes() {
    setState(() {
      //
      switch (_sortBy) {
        case SortBy.priceLowToHigh:
          _filteredDishes.sort((a, b) => (a.price).compareTo(b.price));
          break;
        case SortBy.priceHighToLow:
          _filteredDishes.sort((a, b) => (b.price).compareTo(a.price));
          break;
      }
    });
  }

  String? searchDishes(String? query) {
    // filter the dishes based on the search query
    List<DrinkModel> filteredDishes = [];
    if (_filteredDishes.isEmpty) {
      setState(() {
        _filteredDishes = _dishes;
      });
      return 'Không tìm thấy món :((';
    }
    if (query == null || query == '') {
      filteredDishes = _dishes;
      return null;
    } else {
      filteredDishes = _dishes.where((dish) {
        String dishName = dish.drinkName.toString();
        //Bỏ dấu ở tên món và từ khoá tìm kiếm để tìm kiếm dễ dàng hơn
        String normalizedDishName = removeDiacritics(dishName.toLowerCase());
        String normalizedSearch = removeDiacritics(query.toLowerCase());
        return normalizedDishName.contains(normalizedSearch);
      }).toList();
      setState(() {
        _filteredDishes = filteredDishes;
      });
      if (_filteredDishes.isEmpty) {
        setState(() {
          _filteredDishes = _dishes;
        });
        return 'Không tìm thấy món :((';
      }
      return 'Tìm thấy ${_filteredDishes.length}';
    }
  }

  Future<void> onRefresh() async {
    await loadDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: '${widget.category.categoryName}',
        appBarBackgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: mediaHeight(context, 50),
              ),
              CustomInputTextField(
                controller: searchController,
                labelText: 'Tìm món',
                hintText: 'Nhập gì đó đi...',
                onChanged: searchDishes,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Xếp theo'),
                  PopupMenuButton<SortBy>(
                    icon: Image.asset(
                      'assets/icon/menu_icon.png',
                      color: Colors.black,
                      scale: 4,
                    ),
                    onSelected: (SortBy value) {
                      setState(() {
                        _sortBy = value;
                        sortDishes();
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<SortBy>>[
                      const PopupMenuItem<SortBy>(
                        value: SortBy.priceLowToHigh,
                        child: Text('Giá: Thấp đến cao'),
                      ),
                      const PopupMenuItem<SortBy>(
                        value: SortBy.priceHighToLow,
                        child: Text('Giá: Cao đến thấp'),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: mediaHeight(context, 50),
              ),
              DishesGridView(drinks: _filteredDishes),
            ],
          ),
        ),
      ),
    );
  }
}

class DishesGridView extends StatelessWidget {
  final List<DrinkModel> drinks;

  const DishesGridView({Key? key, required this.drinks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MasonryGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drinks.length,
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final item = drinks[index];
          return InkWell(
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
                  return OrderDetailsBottomSheet(
                    drink: item,
                  );
                },
              );
            },
            child: Card(
              shadowColor: const Color.fromARGB(66, 52, 50, 50).withOpacity(1),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(item.imageUrl),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.drinkName,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatCurrency(item.price),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          '${item.category.categoryName}',
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
