import 'dart:convert';

import 'package:april_store/app/model/produk_model.dart';
import 'package:http/http.dart' as http;

class AllServices {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Products>> getProduk(int limit, int skip) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products?limit=$limit&skip=$skip'));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      var rawData = getPostsData['products'] as List;
      var listData = rawData.map((i) => Products.fromJson(i)).toList();
      return listData;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  Future<List<Products>> searchProduk(String search) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products/search?q=$search'));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      var rawData = getPostsData['products'] as List;
      var listData = rawData.map((i) => Products.fromJson(i)).toList();
      return listData;
    } else {
      throw Exception('Failed to load Posts');
    }
  }
}
