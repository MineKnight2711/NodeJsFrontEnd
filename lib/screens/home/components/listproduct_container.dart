import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/configs/colors.dart';
import 'package:quanlyquantrasua/configs/font.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';
import '../../../utils/format_currency.dart';
import '../../product-detail/product_bottom_sheet/details_bottom_sheet.dart';
import '../data/list_dish.dart';
import 'list_category.dart';

class GroceryContainer extends StatelessWidget {
  const GroceryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        MenuCategoryList(),
        SizedBox(
          height: 15.h,
        ),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.5,
            viewportFraction: 0.72,
            enlargeCenterPage: true,
          ),
          items: ListDataTemp.banner
              .map(
                (item) => Card(
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(item, fit: BoxFit.fill),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 26.22,
        ),
        Container(
          height: 20.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text("Món Mới Về Nè...",
                  style: CustomFonts.nunitoFont(fontSize: 14.r)),
              const Spacer(),
              Text(
                "Xem Tất Cả",
                style: CustomFonts.nunitoFont(
                    fontSize: 14.r, color: AppColors.appTheme),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 13.87,
        ),
        ListDishView(),
      ],
    );
  }
}

class ListDishView extends StatelessWidget {
  ListDishView({Key? key}) : super(key: key);

  final controller = Get.find<DrinkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listDrink.isNotEmpty) {
        int numberOfItems = controller.listDrink.length;
        double itemHeight = 0.45.sh;
        int numRows =
            (numberOfItems + 1) ~/ 2; // Use integer division to round up

        double height = numRows * itemHeight;
        return Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: MasonryGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listDrink.length,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              final drink = controller.listDrink[index];
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
                        drink: drink,
                      );
                    },
                  );
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: AspectRatio(
                          aspectRatio: 160.06 / 190.42,
                          child: Image.network(
                            drink.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drink.drinkName,
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "${drink.category.categoryName}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff8B9E9E),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  formatCurrency(drink.price),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff02A88A),
                                  ),
                                ),
                                const SizedBox(width: 6.66),
                              ],
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
          // GridView.count(
          //     crossAxisCount: 2,
          //     childAspectRatio: 0.6,
          //     physics: const NeverScrollableScrollPhysics(),
          //     // staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          //     mainAxisSpacing: 15,
          //     crossAxisSpacing: 8.0,
          //     // itemCount: controller.listDrink.length,
          //     children: controller.listDrink
          //         .map(
          //           (drink) =>
          //         )
          //         .toList()),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
