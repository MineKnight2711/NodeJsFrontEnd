import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quanlyquantrasua/api/account/account_api.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';

import '../model/account_model.dart';
import '../widgets/custom_widgets/messages_widget.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
  final controller = Get.find<AccountApi>();
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController phonenumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController birthdayController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Nhập thông tin của bạn:',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phonenumberController,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(
                  labelText: 'Giới tính',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: birthdayController,
                decoration: const InputDecoration(
                  labelText: 'Ngày sinh',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 15),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        child: FloatingActionButton(
          onPressed: () async {
            Accounts accounts = Accounts();
            accounts.username = usernameController.text;
            accounts.password = passwordController.text;
            accounts.phoneNumber = phonenumberController.text;
            accounts.email = emailController.text;
            accounts.gender = genderController.text;
            // create a DateFormat object for the input date format
            DateFormat inputFormat = DateFormat('dd/MM/yyyy');

            // parse the input string into a DateTime object
            DateTime birthday = inputFormat.parse(birthdayController.text);
            accounts.birthday = birthday;
            accounts.address = addressController.text;
            accounts.accounttypeid = 3;
            await controller.createAccount(accounts).whenComplete(() {
              CustomSnackBar.showCustomSnackBar(
                  context, 'Thêm tài khoản thành công', 2,
                  backgroundColor: Colors.blue);
              Navigator.pop(context);
            });
          },
          backgroundColor: Colors.blue,
          shape: const StadiumBorder(),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              SizedBox(width: 5.0),
              Text("Tạo"),
            ],
          ),
        ),
      ),
    );
  }
}
