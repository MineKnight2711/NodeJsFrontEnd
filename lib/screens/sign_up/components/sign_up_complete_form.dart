// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/configs/mediaquery.dart';
import 'package:quanlyquantrasua/controller/register_controller.dart';
import 'package:quanlyquantrasua/model/account_model.dart';
import 'package:quanlyquantrasua/screens/sign_in/sign_in_screen.dart';
import 'package:quanlyquantrasua/utils/save_image.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/gender_chose.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/messages_widget.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/showLoading.dart';
import '../../../api/account/account_api.dart';
import '../../../test/select_image_constant/image_select.dart';
import '../../../widgets/custom_widgets/custom_input_textformfield.dart';
import '../../../widgets/custom_widgets/datetime_picker.dart';
import '../../../widgets/custom_widgets/default_button.dart';
import '../../../widgets/custom_widgets/transition.dart';

class SignUpCompleteForm extends StatelessWidget {
  SignUpCompleteForm({super.key});
  final controller = Get.find<AccountApi>();
  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaHeight(context, 1),
      width: mediaWidth(context, 1),
      child: SingleChildScrollView(
        child: Obx(
          () => Form(
            child: Column(children: [
              ImagePickerWidget(
                onImageSelected: (value) {
                  registerController.image = value;
                },
              ),
              BirthdayDatePickerWidget(
                initialDate: DateTime.now(),
                onChanged: (value) {
                  registerController.date = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomInputTextField(
                onChanged: registerController.validateFullname,
                controller: registerController.fullnameController,
                labelText: 'Họ và tên',
                hintText: 'Nhập họ và tên',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomInputTextField(
                  onChanged: registerController.validatePhonenumber,
                  controller: registerController.phonenumberController,
                  labelText: 'Nhập số điện thoại',
                  hintText: 'Số điện thoại'),
              GenderSelectionWidget(
                size: 1.7,
                onChanged: (value) {
                  registerController.selectedGender = value;
                },
              ),
              CustomInputTextField(
                  onChanged: registerController.validateAddress,
                  controller: registerController.addressController,
                  labelText: 'Nhập địa chỉ',
                  hintText: 'Địa chỉ'),
              const SizedBox(
                height: 30,
              ),
              DefaultButton(
                enabled: registerController.isValidFullname.value &&
                    registerController.isValidPhonenumber.value &&
                    registerController.isValidAddress.value,
                text: 'Đăng ký',
                press: () async {
                  Accounts accounts = Accounts();
                  accounts.email = registerController.emailController.text;
                  accounts.phoneNumber =
                      registerController.phonenumberController.text;
                  accounts.password = registerController.passController.text;
                  if (registerController.selectedGender != null) {
                    accounts.gender = registerController.selectedGender;
                  } else {
                    CustomSnackBar.showCustomSnackBar(
                        context, 'Bạn chưa chọn giới tính', 1,
                        backgroundColor: Colors.red);
                    return;
                  }
                  if (registerController.image == null) {
                    accounts.imageUrl = await uploadDefaultImage(
                        '${accounts.email}_${accounts.phoneNumber}');
                  } else {
                    accounts.imageUrl = await saveImage(
                        registerController.image,
                        '${accounts.email}_${accounts.phoneNumber}');
                  }
                  accounts.username =
                      registerController.fullnameController.text;
                  accounts.accounttypeid = 2;
                  accounts.address = registerController.addressController.text;
                  if (registerController.date != null) {
                    accounts.birthday = registerController.date;
                  } else {
                    CustomSnackBar.showCustomSnackBar(
                        context, 'Vui lòng kiểm tra ngày sinh!', 1,
                        backgroundColor: Colors.red);
                    return;
                  }
                  showLoadingAnimation(context);
                  await controller.createAccount(accounts).whenComplete(() {
                    slideinTransition(context, const SignInScreen());
                    registerController.onClose();
                  });
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// TextFormField buildFullNameField() {
//   return TextFormField(
//     cursorColor: Colors.black,
//     decoration: const InputDecoration(
//       hintText: 'Nhập họ và tên',
//       labelText: 'Họ và tên',
//     ),
//   );
// }

// TextFormField buildBirthDayField() {
//   return TextFormField(
//     cursorColor: Colors.black,
//     decoration: InputDecoration(
//       hintText: 'Nhập ngày sinh',
//       labelText: 'Ngày sinh',
//       helperText: 'Ngày sinh phải có định dạng là ngày/tháng/năm',
//       helperStyle: kHelperTextStyle,
//     ),
//   );
// }

// TextFormField buildPhoneNumberField() {
//   return TextFormField(
//     cursorColor: Colors.black,
//     decoration: const InputDecoration(
//       hintText: 'Nhập số điện thoại',
//       labelText: 'Số điện thoại',
//     ),
//   );
// }

// TextFormField buildAddressField() {
//   return TextFormField(
//     cursorColor: Colors.black,
//     decoration: const InputDecoration(
//       hintText: 'Nhập địa chỉ',
//       labelText: 'Địa chỉ',
//     ),
//   );
// }
