import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quanlyquantrasua/api/account/account_api.dart';
import 'package:quanlyquantrasua/controller/cart_controller.dart';
import 'package:quanlyquantrasua/controller/change_password_controller.dart';
import 'package:quanlyquantrasua/controller/profile_controller.dart';
import 'package:quanlyquantrasua/screens/home/home_screens.dart';
import 'package:quanlyquantrasua/screens/profile/profile_screen.dart';
import 'package:quanlyquantrasua/screens/sign_in/change_password_screen.dart';

import 'package:quanlyquantrasua/screens/sign_in/sign_in_screen.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/messages_widget.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/transition.dart';
import '../../cart/cart_view.dart';
import 'draw_header_bar.dart';

// ignore: must_be_immutable
class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final controller = Get.find<AccountApi>();
  final cartController = Get.find<CartController>();
  CustomHomeAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        child: const Icon(
          Icons.home_outlined,
          size: 30,
        ),
        onTap: () {
          slideinTransition(context, HomeScreenView());
        },
      ),
      backgroundColor: const Color(0xff06AB8D),
      title: Text(
        "Home",
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      actions: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  slideinTransition(context, const CartScreen());
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
                    '${cartController.cartItem.length}',
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
        SizedBox(
          width: 45,
          child: Obx(() {
            final userInfo = controller.accountRespone.value;
            if (userInfo == null) {
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
                    slideinTransition(context, const SignInScreen());
                  },
                ),
              );
            } else {
              String? imageUrl = controller.accountRespone.value?.imageUrl;
              return Container(
                width: 45,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageUrl != null
                        ? Image.network(
                            imageUrl,
                          ).image
                        : Image.asset(
                            'assets/images/profile.png',
                          ).image,
                    fit: BoxFit.fill,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
              );
            }
          }),
        ),
        const SizedBox(
          width: 23.0,
        ),
      ],
    );
  }

  late String? avt;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget buildDrawer(BuildContext context) {
    controller.fetchCurrent();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(() {
            if (controller.accountRespone.value != null) {
              final accounts = controller.accountRespone.value!;
              if (accounts.imageUrl != null) {
                avt = accounts.imageUrl;
              } else {
                avt = 'assets/images/avt.png';
              }
              return MyDrawerHeader(
                fullName: '${accounts.fullName}',
                email: '${accounts.email}',
                avatarUrl: '$avt',
              );
            }
            return const CircularProgressIndicator();
          }),
          ListTile(
            title: const Text('Cập nhật thông tin'),
            onTap: () {
              if (controller.accountRespone.value == null) {
                CustomErrorMessage.showMessage(
                    'Có lỗi xảy ra!\nVui lòng đăng nhập lại để thực hiện thao tác này! ');
                return;
              }
              Get.put(ProfileController(controller.accountRespone.value!));
              slideinTransition(context,
                  EditProfileScreen(account: controller.accountRespone.value!));
            },
          ),
          ListTile(
            title: const Text('Đổi mật khẩu'),
            onTap: () {
              Get.put(ChangePasswordController());
              slideinTransition(context, ChangePasswordScreen());
            },
          ),
          ListTile(
            title: const Text('Đơn hàng'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Đăng xuất'),
            onTap: () {
              controller.logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
