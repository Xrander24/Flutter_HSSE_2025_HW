import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:hsse_cat_tinder/data/models/cat_model.dart';

class CatApiSource {
  static String apiUrl =
      'https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=1&api_key=${dotenv.env['API_KEY']}';

  Future<List<CatModel>> fetchCats() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cats');
    }
  }
}
