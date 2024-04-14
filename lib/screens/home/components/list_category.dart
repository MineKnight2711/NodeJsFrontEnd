import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/configs/colors.dart';
import 'package:quanlyquantrasua/configs/font.dart';
import 'package:quanlyquantrasua/controller/category_controller.dart';

class MenuCategoryList extends StatelessWidget {
  MenuCategoryList({Key? key}) : super(key: key);

  final controller = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    controller.getAllCategory();
    return Card(
      color: AppColors.white100,
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 80.h,
        child: Obx(
          () {
            if (controller.listCategory.isNotEmpty) {
              return ListView.builder(
                  itemCount: controller.listCategory.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var item = controller.listCategory[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        // slideinTransition(
                        //     context, DishByCategory(category: item));
                      },
                      child: Container(
                        width: 40.w,
                        // height: 70.h,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.w,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: item.imageUrl != null
                                  ? Image.network(
                                      "${item.imageUrl}",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/milktea.png",
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                              "${item.categoryName}",
                              overflow: TextOverflow.ellipsis,
                              style: CustomFonts.nunitoFont(fontSize: 12.r),
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
    );
  }
}
