import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/profile_controller.dart';
import 'package:quanlyquantrasua/model/user_model.dart';
import 'package:quanlyquantrasua/utils/select_image_constant/image_select.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_input_textformfield.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/default_button.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel user;
  EditProfileScreen({super.key, required this.user});
  final profileController = Get.find<ProfileController>();
  final accountController = Get.find<AccountController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarBackgroundColor: Colors.white,
        onPressed: () {
          Get.delete<ProfileController>();
          Navigator.pop(context);
        },
        title: 'Cập nhật thông tin',
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: mediaHeight(context, 23),
          ),
          ImagePickerWidget(
            onImageSelected: (value) {
              profileController.image = value;
            },
            currentImageUrl: user.imageUrl,
          ),
          SizedBox(
            height: mediaHeight(context, 23),
          ),
          // BirthdayDatePickerWidget(
          //   initialDate: user.birthday != null
          //       ? DateTime.parse(account.birthday!)
          //       : DateTime.now(),
          //   onChanged: (value) {
          //     profileController.date = value;
          //   },
          // ),
          SizedBox(
            height: mediaHeight(context, 50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                CustomInputTextField(
                  controller: profileController.fullnameController,
                  hintText: 'Nhập họ tên...',
                  labelText: 'Họ và tên...',
                  onChanged: profileController.validateFullname,
                ),
                SizedBox(
                  height: mediaHeight(context, 40),
                ),
                CustomInputTextField(
                  controller: profileController.phonenumberController,
                  hintText: 'Nhập số điện thoại...',
                  labelText: 'Số điện thoại',
                  onChanged: profileController.validatePhonenumber,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: mediaHeight(context, 40),
                ),
                CustomInputTextField(
                  controller: profileController.addressController,
                  hintText: 'Nhập địa chỉ...',
                  labelText: 'Địa chỉ',
                  onChanged: profileController.validateAddress,
                ),
                SizedBox(
                  height: mediaHeight(context, 40),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => DefaultButton(
                enabled: profileController.isValidPhonenumber.value &&
                    profileController.isValidAddress.value &&
                    profileController.isValidFullname.value,
                text: 'Lưu',
                press: () async {
                  // AccountUpdate accountUpdate = AccountUpdate();
                  // accountUpdate.accountId =
                  //     accountController.accountRespone.value?.accountId;
                  // accountUpdate.fullName =
                  //     profileController.fullnameController.text;
                  // accountUpdate.birthday = profileController.date ??
                  //     DateTime.parse(
                  //         accountController.accountRespone.value?.birthday ??
                  //             '');
                  // accountUpdate.phoneNumber =
                  //     profileController.phonenumberController.text;
                  // accountUpdate.address =
                  //     profileController.addressController.text;
                  // if (profileController.image != null) {
                  //   // accountUpdate.imageUrl = await saveImage(
                  //   //     profileController.image,
                  //   //     "${accountController.accountRespone.value?.email}_${accountController.accountRespone.value?.phoneNumber}");
                  // } else {
                  //   accountUpdate.imageUrl =
                  //       accountController.accountRespone.value?.imageUrl;
                  // }
                  // showLoadingAnimation(context);
                  // await accountController.updateAccount(accountUpdate).then(
                  //     (value) => Future.delayed(const Duration(seconds: 1), () {
                  //           slideinTransitionNoBack(context, HomeScreenView());
                  //         }));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
