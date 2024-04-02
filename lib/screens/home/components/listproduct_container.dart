import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/api/product/api_product.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import '../../../utils/format_currency.dart';
import '../../product-detail/product_bottom_sheet/details_bottom_sheet.dart';
import '../banner/banner_list.dart';
import 'list_category.dart';

class GroceryContainer extends StatelessWidget {
  const GroceryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///// HIEN THI DANH MUC TU WIDGET CATEGORY O DAY ////
        Column(
          children: [
            MenuCategoryList(),
          ],
        ),
        const SizedBox(
          height: 19.0,
        ),
        //WIDGET HIEN THI BANNER VOUCHER O DAY//
        const Column(
          children: [
            BannerList(),
          ],
        ),
        const SizedBox(
          height: 26.22,
        ),
        Container(
          height: 20.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text(
                "Món Mới Về Nè...",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                "Xem Tất Cả",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1CB069),
                ),
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

  final controller = Get.find<DishApi>();

  @override
  Widget build(BuildContext context) {
    controller.getAllDish();

    return Obx(() {
      if (controller.listDish.value != null) {
        int numberOfItems = controller.listDish.value!.length;
        double itemHeight = mediaHeight(context, 8);

        int mainAxisCount = 15;
        double height = (numberOfItems + mainAxisCount).ceil() * itemHeight;

        return Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            mainAxisSpacing: 15,
            crossAxisSpacing: 8.0,
            itemCount: controller.listDish.value!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = controller.listDish.value![index];
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
                        dish: item,
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
                            "${item.image}",
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
                              "${item.dishName}",
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "${item.categories?.categoryName}",
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
                                  formatCurrency(item.price ?? 0),
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
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
