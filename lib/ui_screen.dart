// import 'package:flutter/material.dart';
// import 'package:practice/search_provider.dart';
// import 'package:provider/provider.dart';
// import 'NewPage.dart';
// import 'ProductModel.dart';
//
// class ProductGrid extends StatefulWidget {
//   @override
//   _ProductGridState createState() => _ProductGridState();
// }
//
// class _ProductGridState extends State<ProductGrid> {
//
//   TextEditingController searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//
//
//
//
//
//
//
//   void performSearch() {
//     final searchString = searchController.text;
//     if (searchString.isNotEmpty) {
//       // When searching, clear the lazy loading page
//       setState(() {
//         pageNumber = 1;
//       });
//       productProvider?.searchProducts(searchString);
//     } else {
//       // If the search field is empty, don't clear the search results,
//       // but keep isSearching true if filtering is still applied
//       productProvider?.clearSearchResults();
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 30),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: searchController,
//                     onChanged: (searchString) {
//                       if (searchString.isEmpty) {
//                         // If the search field is empty, clear the search results
//                         productProvider?.clearSearchResults();
//                       } else {
//                         // If there is text in the search field, perform search
//                         productProvider?.searchProducts(searchString);
//                       }
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search products...',
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: performSearch,
//                   child: Text('Search'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//             Expanded(
//               child: Stack(
//                 children: [
//                   GridView.builder(
//                     controller: _scrollController,
//                     itemCount: productProvider?.products.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemBuilder: (context, index) {
//                       if (index < provider.products.length) {
//                         Data tempdata = provider.products[index];
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => NewPage()),
//                             );
//                           },
//                           child: Container(
//                             height: 300,
//                             child: Card(
//                               elevation: 3,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Image.network(
//                                     "https://circlek.thezits.com/upload/${tempdata.photo}",
//                                     height: 100,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Text(
//                                       "${tempdata.itemName ?? "product"}",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 10,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       } else if (provider.isLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       } else {
//                         return Container(); // Placeholder for the loading indicator
//                       }
//                     },
//                   ),
//                   if (provider.searchResults.isNotEmpty)
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         color: Colors.white, // Background color for the overlay
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: provider.searchResults.length,
//                           itemBuilder: (context, index) {
//                             // Build your filtered search result widgets here
//                             return ListTile(
//                               title: Text(provider.searchResults[index].itemName ?? "product"),
//                               // Add any other information you want to display
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//
//       ),
//     );
//   }
// }
//
// //
// // class SearchScreen extends StatefulWidget {
// //   @override
// //   _SearchScreenState createState() => _SearchScreenState();
// // }
// //
// // class _SearchScreenState extends State<SearchScreen> {
// //   ProductProvider? productProvider;
// //   TextEditingController searchController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     productProvider = Provider.of<ProductProvider>(context, listen: false);
// //   }
// //
// //   void performSearch() {
// //     final searchString = searchController.text;
// //     productProvider?.searchProducts(searchString);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Product Search'),
// //       ),
// //       body: Column(
// //         children: [
// //           TextField(
// //             controller: searchController,
// //             decoration: InputDecoration(
// //               hintText: 'Search products...',
// //             ),
// //           ),
// //           ElevatedButton(
// //             onPressed: performSearch,
// //             child: Text('Search'),
// //           ),
// //           Consumer<ProductProvider>(
// //             builder: (context, provider, child) {
// //               if (provider.isLoading) {
// //                 return CircularProgressIndicator();
// //               } else {
// //                 return Expanded(
// //                   child: GridView.builder(
// //                     itemCount: provider.filteredProducts.length,
// //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 2,
// //                       crossAxisSpacing: 16,
// //                       mainAxisSpacing: 16,
// //                     ),
// //                     itemBuilder: (context, index) {
// //                       var data = provider
// //                           .filteredProducts[index].details?.data?[index];
// //                       return Card(
// //                         elevation: 3,
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Image.network(
// //                               "${provider.products[index].details?.data?[index].photo}",
// //                               height: 100,
// //                               width: double.infinity,
// //                               fit: BoxFit.cover,
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Text(
// //                                 data?.itemName ?? "",
// //                                 style: TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 16,
// //                                 ),
// //                               ),
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Text(
// //                                 'Price: ${data?.price}',
// //                                 style: TextStyle(
// //                                   color: Colors.green,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 );
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // return ProductCard(
// // product: provider.filteredProducts[index]);
