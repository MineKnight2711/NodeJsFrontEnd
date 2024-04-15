import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/font.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/cart_controller.dart';
import 'package:quanlyquantrasua/controller/auth_controller.dart';
import 'package:quanlyquantrasua/screens/sign_in/sign_in_screen.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/transition.dart';
import '../../cart/cart_view.dart';

// ignore: must_be_immutable
class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAvatarTap;
  final controller = Get.find<AccountController>();
  final cartController = Get.find<CartController>();
  CustomHomeAppBar({super.key, required this.onAvatarTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: 45.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Obx(() {
          if (controller.userSession.value == null) {
            return Container(
              width: 45,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: Image.asset(
                    'assets/images/profile.png',
                    scale: 1,
                  ).image,
                  fit: BoxFit.fill,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.put(AuthController());
                  slideinTransition(context, const SignInScreen());
                },
              ),
            );
          } else {
            return Container(
              width: 45,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: controller.userSession.value?.imageUrl != null
                      ? Image.network(
                          "${controller.userSession.value?.imageUrl}",
                        ).image
                      : Image.asset(
                          'assets/images/profile.png',
                        ).image,
                  fit: BoxFit.fill,
                ),
              ),
              child: GestureDetector(
                onTap: onAvatarTap,
              ),
            );
          }
        }),
      ),
      backgroundColor: const Color(0xff06AB8D),
      centerTitle: true,
      title: Text(
        "BrosMilkTea",
        style: CustomFonts.nunitoFont(fontSize: 18.r, color: Colors.white),
      ),
      actions: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  controller.fetchCurrent();
                  cartController.getByUserId();
                  slideinTransition(context, CartScreen());
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 0,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Obx(
                  () => Text(
                    '${cartController.listCart.length}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 23.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
