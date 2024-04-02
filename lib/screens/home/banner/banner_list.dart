import 'package:flutter/material.dart';

import '../data/list_dish.dart';

class BannerList extends StatelessWidget {
  const BannerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: SizedBox(
        height: 80.0,
        child: ListView.builder(
          itemCount: ListDataTemp.banner.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var item = ListDataTemp.banner[index];
            return Container(
              height: 120.0,
              width: 250,
              margin: const EdgeInsets.only(
                left: 28.0,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "$item",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
