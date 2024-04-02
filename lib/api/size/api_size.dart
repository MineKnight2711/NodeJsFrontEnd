import 'dart:convert';

import 'package:get/get.dart';
import 'package:quanlyquantrasua/model/size_model.dart';
import 'package:http/http.dart' as http;
import '../base_url_api.dart';

class SizeApi extends GetxController {
  List<SizeModel>? listSize = <SizeModel>[].obs();
  @override
  void onInit() {
    super.onInit();
    getAllSize();
  }

  Future getAllSize() async {
    try {
      final url = Uri.parse(ApiUrl.apiGetAllSize);

      final response = await http.get(url);
      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      listSize = jsonData.map((data) => SizeModel.fromJson(data)).toList();
      if (response.statusCode != 200) {
        throw Exception('Load size thất bại: ${response.body}');
      }
    } catch (e) {
      throw Exception('Không thể kết nối đến server: $e');
    }
  }
}
