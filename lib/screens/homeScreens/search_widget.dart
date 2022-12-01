import 'dart:convert';

import 'package:dealsbuck/screens/homeScreens/Recommended%20Screen/Product%20Screen/productScreen.dart';
import 'package:dealsbuck/screens/homeScreens/homeScreen_controller.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import '../../model/searchResponseModel.dart';
import '../../utils/urlsConstant.dart';
import '../notifications_screen.dart';

class SearchBox extends StatefulWidget {
  SearchBox({Key? key, required this.contextt}) : super(key: key);
  BuildContext contextt;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();
  SearchResponseModel? _searchResponseModel;
  final homeController = HomeController();

  Future<SearchResponseModel?> getSearchResult(search) async {
    var lati = await HelperFunction.getLatitude();
    var longi = await HelperFunction.getLongitude();
    try {
      // var response = await Http.get(Uri.parse("$searchUrl$lati/$longi/$search"));
      var response = await Http.get(
          Uri.parse("${searchUrl}30.71937720/76.71289250/$search"));
      // var res = SearchResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        setState(() {
          _searchResponseModel =
              SearchResponseModel.fromJson(jsonDecode(response.body));
        });
      }
      print("search response___$_searchResponseModel");
      return _searchResponseModel;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 35,
            // child: TextField(
            //   onSubmitted: (text){
            //       getSearchResult(text);
            //       print("hbdkjwfblfne");
            //       homeController.changeStatus(false);
            //       print(homeController.isSearch.value);
            //   },
            //   controller: searchController,
            //   decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               width: 0, color: Color(0xff001527)),
            //           borderRadius: BorderRadius.circular(8)),
            //       enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               width: 1, color: Color(0xff001527)),
            //           borderRadius: BorderRadius.circular(8)),
            //       prefixIcon: Icon(
            //         Icons.search,
            //       ),
            //       hintText: "Search",
            //       alignLabelWithHint: true,
            //       fillColor: Colors.white,
            //       filled: true),
            //   textAlignVertical: TextAlignVertical.bottom,
            // ),
            child: Autocomplete<Product>(
              optionsBuilder: (TextEditingValue value) {
                // getSearchResult(value);
                if (value.text.isEmpty) {
                  return List.empty();
                }
                return _searchResponseModel!.input.products
                    .where((element) => element.productName
                        .toLowerCase()
                        .contains(value.text.toLowerCase()))
                    .toList();
              },
              fieldViewBuilder: (BuildContext context,
                      TextEditingController controller,
                      FocusNode node,
                      Function onSubmit) =>
                  TextField(
                onChanged: (value) {
                  getSearchResult(value);
                },
                controller: controller,
                focusNode: node,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Color(0xff001527)),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xff001527)),
                        borderRadius: BorderRadius.circular(8)),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search",
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true),
                textAlignVertical: TextAlignVertical.bottom,
              ),
              onSelected: (value) => print(value.productName),
              displayStringForOption: (Product p) => p.productName,
              optionsViewBuilder: (BuildContext context, Function onSelect,
                  Iterable<Product> producList) {
                return Material(
                  child: ListView.builder(
                      itemCount: producList.length,
                      itemBuilder: (context1, index) {
                        Product p = producList.elementAt(index);
                        // return InkWell(
                        //   onTap: (){
                        //     print("909019029");
                        //     Navigator.of(context1).push(MaterialPageRoute(builder: (context)=> ProductScreen(id: p.id)));
                        //   },
                        //   child: ListTile(
                        //     title: Text(p.productName),
                        //     leading: Image.network('https://dealsbuck.com/${p.featuredImagePath}',
                        //     width: 50,
                        //     height: 50,
                        //     fit: BoxFit.cover,),
                        //   ),
                        // );
                        return SearchTile(product: p, index: index,cont: widget.contextt,);
                      }),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            },
            child: Icon(
              Icons.notifications,
              color: Color(0xffed1b24),
            ))
      ],
    );
  }
}

class SearchTile extends StatelessWidget {
  SearchTile({Key? key, required this.product, required this.index,required this.cont})
      : super(key: key);
  Product product;
  int index;BuildContext cont;

  @override
  Widget build(BuildContext cont) {
    return InkWell(
      onTap: () {
        print("909019029");
        Navigator.pop(cont);
        Navigator.of(cont).push(
            MaterialPageRoute(builder: (_) => ProductScreen(id: product.id)));
      },
      child: ListTile(
        title: Text(product.productName),
        leading: Image.network(
          'https://dealsbuck.com/${product.featuredImagePath}',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
