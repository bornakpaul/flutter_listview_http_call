import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_listview/model/ModelData.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  //'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=1'
  static Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  static List<ModelData> parseModelData(String responseData) {
    var list = json.decode(responseData) as List<dynamic>;
    List<ModelData> modelData =
        list.map((json) => ModelData.fromJson(json)).toList();
    return modelData;
  }

  static Future<List<ModelData>> fetchPosts({int page = 1}) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return compute(parseModelData, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get post');
    }
  }
}
