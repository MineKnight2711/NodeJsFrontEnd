import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/font.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';
import 'package:quanlyquantrasua/model/drink_model.dart';

import '../../configs/colors.dart';
import '../../controller/cart_controller.dart';
import '../../utils/data_convert.dart';
import '../../widgets/custom_input/round_textfield.dart';
import '../product-detail/product_bottom_sheet/details_bottom_sheet.dart';

class DishSearchScreen extends GetView {
  final drinkController = Get.find<DrinkController>();

  final TextEditingController searchController = TextEditingController();
  DishSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true, //Treo như 1 header
              floating: true,
              expandedHeight: 100.h,
              centerTitle: true,
              backgroundColor: AppColors.appTheme,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              title: Text(
                "Tìm món",
                style: CustomFonts.nunitoFont(
                    fontSize: 16.r, color: AppColors.white100),
              ),

              bottom: PreferredSize(
                preferredSize: Size(1.sw, 72.8.h),
                child: Container(
                  width: 0.9.sw,
                  height: 0.065.sh,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: Hero(
                    tag: "searchTextField",
                    child: Material(
                      type: MaterialType.transparency,
                      child: RoundTextfield(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "Nhập gì đó đi...",
                        controller: searchController,
                        onChanged: (dishName) {
                          drinkController.searchDish(dishName ?? '');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kết quả",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (drinkController.listSearchDrink.isNotEmpty) {
                      return Column(
                        children: drinkController.listSearchDrink
                            .map((dishItem) => DishItem(drink: dishItem))
                            .toList(),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DishItem extends StatelessWidget {
  final DrinkModel drink;
  DishItem({super.key, required this.drink});
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      height: 130.h,
      width: 400.w - 20,
      child: Card(
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
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
                  drink: drink,
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: SizedBox(
                  width: 100.w,
                  height: 120.h,
                  child: Image.network(
                    "${drink.imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        drink.drinkName,
                        style: CustomFonts.customGoogleFonts(fontSize: 16.r),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        DataConvert.formatCurrency(drink.price),
                        style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
