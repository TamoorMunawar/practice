// import 'package:flutter/material.dart';
// import 'package:practice/ProductModel.dart';
// import 'package:practice/searchModel.dart' as Search;
// import 'fiteredProduct_Service.dart';
//
// class ProductProvider with ChangeNotifier {
//   final ProductService productService = ProductService();
//
//   List<Data> products = [];
//   List<Search.Data> filteredProducts = [];
//   int currentPage = 1;
//   bool isLoading = false;
//
//
//
//
//   Future<void> searchProducts(String searchString) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final filtered = await productService.fetchFilteredProducts(searchString);
//       Search.SearchProductModel newSearch =
//           await productService.fetchFilteredProducts(searchString);
//       Search.Details? details = newSearch.details;
//       List<Search.Data>? alldat = details!.data;
//       filteredProducts.addAll(alldat!);
//       print(filteredProducts.length);
//       print("filtered product");
//     } catch (e) {
//       // Handle errors here
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void clearSearchResults() {
//     filteredProducts.clear();
//     notifyListeners();
//   }
// }
