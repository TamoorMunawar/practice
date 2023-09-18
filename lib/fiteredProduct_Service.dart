import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/searchModel.dart';
import 'package:practice/search_provider.dart';
import 'package:provider/provider.dart';
import 'ProductModel.dart';

class ProductService {
  Future<ProductModel> fetchProducts(
      int page, Map<String, dynamic> filters) async {
    final response = await http.get(
      Uri.parse(
          'http://circlek.thezits.com/mobileappv2/apiv1/getProductsLists?user_token=auld0g8dszgomrwd41d8cd98f00b204e9800998ecf8427e&merchant_id=19&page=$page'),
    );
    if (response.statusCode == 200) {
      ProductModel product = ProductModel.fromJson(jsonDecode(response.body));
      print(response.body);
      // print(data);
      // final productList = (data['details']['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      // //     .toList();
      // print(productList.length);
      print("ccccccccccccccccccccccccccccccchut");
      return product;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<SearchProductModel> fetchFilteredProducts(String searchString) async {
    final response = await http.get(
      Uri.parse(
          'http://circlek.thezits.com/mobileappv2/apiv1/searchMerchantFood1?device_uiid=92&search_string=$searchString'),
    );

    if (response.statusCode == 200) {
      SearchProductModel search =
          SearchProductModel.fromJson(jsonDecode(response.body));
      // final data = jsonDecode(response.body);
      // final productList = (data as List)
      //     .map((json) => SearchProductModel.fromJson(json))
      //     .toList();

      return search;
    } else {
      throw Exception('Failed to load filtered products');
    }
  }
}
