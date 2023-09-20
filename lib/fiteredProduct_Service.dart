import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/searchModel.dart';


class ProductService {
  List<Data> _searchProducts = [];

  Future<void> fetchFilteredProducts(String searchString) async {
    final response = await http.get(
      Uri.parse(
          'http://circlek.thezits.com/mobileappv2/apiv1/searchMerchantFood1?device_uiid=92&search_string=$searchString'),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      _searchProducts.addAll((responseData['details']['data'] as List).map((e) => Data.fromJson(e)).toList());

    } else {
      throw Exception('Failed to load filtered products');
    }
  }
}
