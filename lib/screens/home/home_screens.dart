import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/cart_controller.dart';
import 'package:quanlyquantrasua/controller/category_controller.dart';
import 'package:quanlyquantrasua/controller/drink_controller.dart';
import 'package:quanlyquantrasua/screens/home/components/drawer.dart';
import 'components/home_appbar.dart';
import 'components/listproduct_container.dart';
import 'components/search_header.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final accountController = Get.find<AccountController>();
  final _categoryController = Get.find<CategoryController>();
  final _drinkController = Get.find<DrinkController>();
  // final toppingController = Get.put(ToppingApi());

  final cartController = Get.put(CartController());
  Future<void> _refesh() async {
    _categoryController.getAllCategory();
    _drinkController.getAllDrink();
    // await toppingController.getAllTopping();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          key: scaffoldKey,

          ////////////////MENU NAVIGATION BAR BEN TRAI O DAY//////////////
          appBar: CustomHomeAppBar(
            onAvatarTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          drawer: accountController.userSession.value != null
              ? HomeDrawer(accountController: accountController)
              : null,
          body: RefreshIndicator(
              onRefresh: _refesh,
              color: Colors.blue,
              child: CustomScrollView(
                slivers: [
                  LocationAndSearchHeader(accountController: accountController),
                  const SliverToBoxAdapter(child: GroceryContainer()),
                ],
              )),
        ),
      ),
    );
  }
}
