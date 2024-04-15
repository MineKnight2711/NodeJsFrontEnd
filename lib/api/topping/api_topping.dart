import 'package:http/http.dart' as http;
import '../base_url_api.dart';

class ToppingApi {
  Future getAllTopping() async {
    try {
      final url =
          Uri.parse(ApiUrl.apiGetAllToppings); // Replace with your API endpoint

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Load toppings thất bại: ${response.body}');
      }
    } catch (e) {
      throw Exception('Không thể kết nối đến server: $e');
    }
  }
}
