import 'package:flutter/material.dart';
import 'package:practice/search_provider.dart';
import 'package:provider/provider.dart';
import 'NewPage.dart';
import 'ProductModel.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  bool isSearching = false;
  ProductProvider? productProvider;
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int pageNumber = 1; // To keep track of the page for lazy loading
  // To track whether the user is searching

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider?.loadProducts(pageNumber);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreProducts(); // Load more products when scrolled to the end
      }
    });
  }

  Future<void> loadMoreProducts() async {
    if (!productProvider!.isLoading) {
      pageNumber++; // Increment the current page
      await productProvider!.loadProducts(pageNumber);
    }
  }

  void performSearch() {
    final searchString = searchController.text;
    if (searchString.isNotEmpty) {
      // When searching, clear the lazy loading page and set isSearching to true
      setState(() {
        pageNumber = 1;
        isSearching = true;
      });
      productProvider?.searchProducts(searchString);
    } else {
      // If the search field is empty, clear the search results and show all products
      setState(() {
        isSearching = false;
      });
      productProvider?.clearSearchResults();
      productProvider?.loadProducts(pageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(
            //   height: 30,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: searchController,
            //         onChanged: (searchString) {
            //           if (searchString.isEmpty) {
            //             // If the search field is empty, clear the search results
            //             productProvider?.clearSearchResults();
            //           } else {
            //             // If there is text in the search field, perform search
            //             productProvider?.searchProducts(searchString);
            //           }
            //         },
            //         decoration: InputDecoration(
            //           hintText: 'Search products...',
            //         ),
            //       ),
            //     ),
            //     ElevatedButton(
            //       onPressed: performSearch,
            //       child: Text('Search'),
            //     ),
            //   ],
            // ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Center(
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (searchString) {
                      isSearching = true;
                      if (searchString.isEmpty) {
                        // If the search field is empty, clear the search results
                        productProvider?.clearSearchResults();
                      } else {
                        // If there is text in the search field, perform search
                        productProvider?.searchProducts(searchString);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(height: 1.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: InkWell(
                        onTap: () {
                          isSearching = false;
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  isSearching = false;
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    isSearching ? provider.filteredProducts : provider.products;

                    return GridView.builder(
                      controller: _scrollController,
                      itemCount: productProvider!.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        Data tempdata = provider.products[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPage()));
                          },
                          child: Container(
                            height: 300,
                            child: Card(
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    "https://circlek.thezits.com/upload/${tempdata.photo}",
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${tempdata.itemName ?? "hi"}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   ProductProvider? productProvider;
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     productProvider = Provider.of<ProductProvider>(context, listen: false);
//   }
//
//   void performSearch() {
//     final searchString = searchController.text;
//     productProvider?.searchProducts(searchString);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Search'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//               hintText: 'Search products...',
//             ),
//           ),
//           ElevatedButton(
//             onPressed: performSearch,
//             child: Text('Search'),
//           ),
//           Consumer<ProductProvider>(
//             builder: (context, provider, child) {
//               if (provider.isLoading) {
//                 return CircularProgressIndicator();
//               } else {
//                 return Expanded(
//                   child: GridView.builder(
//                     itemCount: provider.filteredProducts.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemBuilder: (context, index) {
//                       var data = provider
//                           .filteredProducts[index].details?.data?[index];
//                       return Card(
//                         elevation: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.network(
//                               "${provider.products[index].details?.data?[index].photo}",
//                               height: 100,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 data?.itemName ?? "",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Price: ${data?.price}',
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// return ProductCard(
// product: provider.filteredProducts[index]);
