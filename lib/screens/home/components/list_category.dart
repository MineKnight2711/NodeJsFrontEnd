import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/api/category/api_category.dart';
import 'package:quanlyquantrasua/screens/home/dish_category/list_dish_by_category.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/transition.dart';

class MenuCategoryList extends StatelessWidget {
  MenuCategoryList({Key? key}) : super(key: key);

  final controller = Get.find<CategoryApi>();
  @override
  Widget build(BuildContext context) {
    controller.getAllCategory();
    return SizedBox(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          height: 80.0,
          child: Obx(
            () {
              if (controller.listCategory.value != null) {
                return ListView.builder(
                    itemCount: controller.listCategory.value!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = controller.listCategory.value![index];
                      return GestureDetector(
                        onTap: () {
                          slideinTransition(
                              context, DishByCategory(category: item));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 28.27,
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: item.image != null
                                    ? Image.network("${item.image}")
                                    : Image.asset(
                                        "assets/images/milktea.png",
                                        width: 42.0,
                                        height: 42.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(
                                height: 6.74,
                              ),
                              Text(
                                "${item.categoryName}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
