// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/ProductModel.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Kindacode.com',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  // We will fetch data from this Rest api
  final _baseUrl =
      'https://circlek.thezits.com/mobileappv2/apiv1/getProductsLists';
  final String userToken =
      'auld0g8dszgomrwd41d8cd98f00b204e9800998ecf8427e';
  final int merchantId = 19;
  int _page = 1;
  final int _perPage = 20;
  bool _hasNextPage = true;
  bool _isLoading = false;
  List<Data> _products = [];
Future<void> firstLoad() async{
  setState(() {
    _isLoading = true;
  });
  await loadData();
  setState(() {
    _isLoading = false;
  });
}
  // This function will be called when the app launches (see the initState function)
  Future<void> loadData() async {
    try {
      final res =
      await http.get(Uri.parse('$_baseUrl?user_token=$userToken&merchant_id=$merchantId&page=$_page&per_page=$_perPage',));
      print("$_baseUrl?user_token=$userToken&merchant_id=$merchantId&page=$_page&per_page=$_perPage");
      print(_products.length);
      if(res.statusCode == 200){
        var responseData = json.decode(res.body);
        print(responseData);
        _products.addAll((responseData['details']['data'] as List).map((e) => Data.fromJson(e)).toList());
        print(_products.length);
        setState(() {

        });
      }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _page = 1;
    _products.clear();
    await loadData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    _page = _page+ 1;
    await loadData();
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    firstLoad();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 75,
              child: Container(
                padding: EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'search....',
                    hintStyle: TextStyle(height: 1.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0,left: 5.0),
                      child: Container(
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
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}










