import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';

import '../../../configs/colors.dart';
import '../../../configs/font.dart';
import '../../search_screen/search_drink_screen.dart';

class LocationAndSearchHeader extends StatelessWidget {
  const LocationAndSearchHeader({
    super.key,
    required this.accountController,
  });

  final AccountController accountController;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final headerHeight = 0.13.sh;
        final isScrolledUnder = constraints.scrollOffset > headerHeight - 50;
        return SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: headerHeight,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            background: AnimatedOpacity(
              opacity: !isScrolledUnder ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              curve: const Cubic(0.2, 0.0, 0.0, 1.0),
              child: Container(
                // height: 400.h,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff06AB8D),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24.3),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 24.0,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 15.39,
                            height: 20,
                          ),
                          Text(
                              accountController.userSession.value?.address ??
                                  'Chọn địa điểm',
                              style: CustomFonts.nunitoFont(
                                  fontSize: 14.r, color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.23,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[400]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 21.0,
                          ),
                          Expanded(
                            child: Hero(
                              tag: "searchTextField",
                              child: Material(
                                type: MaterialType.transparency,
                                child: TextFormField(
                                  onTap: () => Get.to(DishSearchScreen(),
                                      transition: Transition.upToDown),
                                  initialValue: null,
                                  decoration: InputDecoration.collapsed(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    hintText: "Tìm kiếm sản phẩm...",
                                    hintStyle: CustomFonts.nunitoFont(
                                        fontSize: 14.r,
                                        color: TextColor.placeholder),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
