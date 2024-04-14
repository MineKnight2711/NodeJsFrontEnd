import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/font.dart';

import '../../configs/colors.dart';
import '../../widgets/custom_input/round_textfield.dart';

class DishSearchScreen extends GetView {
  // final dishController = Get.find<DishController>();
  // final favoriteController = Get.find<FavoriteController>();
  // final cartController = Get.find<CartController>();
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
                          // dishController.searchDish(dishName ?? '');
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
                  // Obx(() {
                  //   if (dishController.listSearchDish.isNotEmpty) {
                  //     return Column(
                  //       children: dishController.listSearchDish
                  //           .map((dishItem) => DishItem(dishItem: dishItem))
                  //           .toList(),
                  //     );
                  //   }
                  //   return const EmptyWidget(
                  //     assetsAnimations: "cat_sleep",
                  //     tilte: "Không tìm thấy món nào..",
                  //   );
                  // })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
