import 'package:dealsbuck/model/categoriesResponseModel.dart';
import 'package:dealsbuck/model/nearByDealsResponseModel.dart';
import 'package:dealsbuck/model/topDealsResponseModel.dart';
import 'package:dealsbuck/screens/appBar.dart';
import 'package:dealsbuck/screens/subCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../utils/internetNotConnected.dart';
import 'homeScreens/Recommended Screen/Product Screen/productScreen.dart';

class ProductsGridListScreen extends StatefulWidget {
  ProductsGridListScreen(
      {Key? key,
      required this.title,
      required this.nearByDealsModel,
      required this.topDealsModel,
      required this.categoriesModel})
      : super(key: key);
  final String title;
  NearByDealsModel nearByDealsModel;
  TopDealsModel topDealsModel;
  CategoriesModel categoriesModel;

  @override
  State<ProductsGridListScreen> createState() => _ProductsGridListScreenState();
}

class _ProductsGridListScreenState extends State<ProductsGridListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: CustomAppBar(
                  widget.title,
                  Container(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      color: Color(0xff001527),
                    ),
                  )),
            ),
            Visibility(
                visible: Provider.of<InternetConnectionStatus>(context) ==
                    InternetConnectionStatus.disconnected,
                child: InternetNotAvailable()),
            Flexible(
                child: widget.title == "Nearby Deals"
                    ? NearByDeals()
                    : widget.title == "Categories"
                        ? Categories()
                        : TopDeals())
          ],
        ),
      ),
    );
  }

  Widget NearByDeals() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  // childAspectRatio: 6 / 7.3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  crossAxisSpacing: 14,
                  crossAxisCount: 3),
              itemCount: widget.nearByDealsModel.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductScreen(
                                  id: widget.nearByDealsModel.data[index].id,
                                )));
                  },
                  child: Container(
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // height: 65,
                            height: MediaQuery.of(context).size.height / 10,
                            // width: 85,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff001527),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  "https://dealsbuck.com/" +
                                      widget.nearByDealsModel.data[index]
                                          .featuredImagePath,
                                  fit: BoxFit.fill, errorBuilder:
                                      (BuildContext context, Object exception,
                                          StackTrace? stackTrase) {
                                return Image.asset(
                                  "assets/defaultImage.png",
                                  fit: BoxFit.cover,
                                );
                              }),
                            ),
                          ),
                          Text(
                            widget.nearByDealsModel.data[index].productName,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff001527)),
                          ),
                          Divider(
                            height: 3,
                            color: Colors.grey,
                            indent: 5,
                            endIndent: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              widget.nearByDealsModel.data[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffed1b24),
                                  fontWeight: FontWeight.w500),
                              // softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget TopDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  //childAspectRatio: 6 / 7.3,
                  // childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height/0.7,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  crossAxisSpacing: 14,
                  crossAxisCount: 3),
              itemCount: widget.topDealsModel.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductScreen(
                                  id: widget.topDealsModel.data![index].id!,
                                )));
                  },
                  child: Container(
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // height: 65,
                            height: MediaQuery.of(context).size.height / 10,
                            // width: 85,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff001527),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  "https://dealsbuck.com/" +
                                      widget.topDealsModel.data![index]
                                          .featuredImagePath!,
                                  fit: BoxFit.fill, errorBuilder:
                                      (BuildContext context, Object exception,
                                          StackTrace? stackTrase) {
                                return Image.asset(
                                  "assets/defaultImage.png",
                                  fit: BoxFit.cover,
                                );
                              }),
                            ),
                          ),
                          Text(
                            widget.topDealsModel.data![index].productName!,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff001527)),
                          ),
                          Divider(
                            height: 3,
                            color: Colors.grey,
                            indent: 5,
                            endIndent: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              widget.topDealsModel.data![index].description!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffed1b24),
                                  fontWeight: FontWeight.w500),
                              // softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget Categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 2.1,
                crossAxisSpacing: 0,
                crossAxisCount: 4),
            itemCount: widget.categoriesModel.data.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SubCategory(
                                title: widget.categoriesModel.data[index].name,
                                id: widget.categoriesModel.data[index].id,
                              )));
                },
                child: Column(
                  children: [
                    Container(
                      height: 57,
                      width: 58,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            "https://dealsbuck.com/" +
                                widget.categoriesModel.data[index].imagePath,
                            fit: BoxFit.fill, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrase) {
                          return Image.asset(
                            "assets/defaultImage.png",
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        widget.categoriesModel.data[index].name,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff001527),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }
}
