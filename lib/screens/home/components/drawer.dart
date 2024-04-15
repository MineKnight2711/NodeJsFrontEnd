import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';

import '../../../controller/change_password_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../widgets/custom_widgets/messages_widget.dart';
import '../../../widgets/custom_widgets/transition.dart';
import '../../profile/profile_screen.dart';
import '../../sign_in/change_password_screen.dart';
import 'draw_header_bar.dart';

class HomeDrawer extends StatelessWidget {
  final AccountController accountController;
  const HomeDrawer({super.key, required this.accountController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(() {
              if (accountController.userSession.value != null) {
                final accounts = accountController.userSession.value!;

                return MyDrawerHeader(
                  fullName: accounts.username,
                  email: accounts.email,
                  avatarUrl: accounts.imageUrl,
                );
              }
              return const CircularProgressIndicator();
            }),
            ListTile(
              title: const Text('Cập nhật thông tin'),
              onTap: () {
                if (accountController.userSession.value == null) {
                  CustomErrorMessage.showMessage(
                      'Có lỗi xảy ra!\nVui lòng đăng nhập lại để thực hiện thao tác này! ');
                  return;
                }
                Get.put(
                    ProfileController(accountController.userSession.value!));
                slideinTransition(
                    context,
                    EditProfileScreen(
                        user: accountController.userSession.value!));
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
                accountController.logout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
