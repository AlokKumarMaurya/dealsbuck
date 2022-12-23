import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as Http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/claimCouponResponseModel.dart';
import '../../../../model/productDetailsModel.dart';

import '../../../../utils/internetNotConnected.dart';
import '../../../../utils/urlsConstant.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductDetailsResponseModel? _productDetailsResponseModel;

  // ShowCouponModel? _showCouponModel;
  ClaimCouponModel? _claimCouponModel;
  String Coupontext = "";
  int? Couponid;

  List<String>? showCoupon;

  void initState() {
    getProduct();
    // showCoupon();
  }

  // Future<ShowCouponModel?> showCoupon() async{
  //   var response = await Http.get(Uri.parse(showCouponUrl + widget.id.toString()));
  //   print("show coupon response+++++++++++++++"+response.body);
  //
  //   setState(() {
  //     _showCouponModel = ShowCouponModel.fromJson(jsonDecode(response.body));
  //   });
  //   return _showCouponModel;
  // }

  Future<ClaimCouponModel?> claimCoupon() async {
    var token = await HelperFunction.getToken();
    print(token);
    print(widget.id.toString());
    Map data = {"product_id": widget.id.toString()};
    var response =
        await Http.post(Uri.parse(claimCouponUrl), body: data, headers: {
      'Authorization': 'Bearer $token',
      // 'Accept': 'application/json',
      // 'Content-Type': 'application/json'
    });
    print("claim Coupon response+++++++++++++" + response.body);
    print("response.statusCode${response.statusCode}");
    setState(() {
      _claimCouponModel = ClaimCouponModel.fromJson(jsonDecode(response.body));
    });
    var res = jsonDecode(response.body);
    if (res["status"] == true) {
      if (res["message"].toString() == "Coupon Already Claimed") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Coupon Already Claimed"),
          backgroundColor: Color(0xff001527),
        ));
        setState(() {
          Coupontext = "";
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Coupon Claim Successfully"),
          backgroundColor: Color(0xff001527),
        ));
        setState(() {
          Coupontext = _claimCouponModel!.data.couponCode;
        });
      }
    }
    return _claimCouponModel;
  }

  // void showCouponMenu() async {
  //   await showMenu(
  //     shape: ContinuousRectangleBorder(
  //       borderRadius: BorderRadius.circular(30),
  //     ),
  //     context: context,
  //     position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width*0.3, 200,0, 0),
  //     items: List.generate(
  //       _showCouponModel!.data.length,
  //           (index) => PopupMenuItem(
  //         value: 1,
  //         child: InkWell(
  //           onTap: () async {
  //             setState(() {
  //               Coupontext = _showCouponModel!.data[index].couponCode;
  //               Couponid = _showCouponModel!.data[index].id;
  //             });
  //
  //             await claimCoupon();
  //             Fluttertoast.showToast(msg: _claimCouponModel!.message);
  //             Navigator.pop(context);
  //           },
  //           child: Text(
  //             _showCouponModel!.data[index].couponCode,
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.bold,
  //               fontFamily: 'Roboto',
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     elevation: 8.0,
  //   ).then((value) {
  //     if (value != null) print(value);
  //   });
  // }

  Future<void> _askedToLead(String couponCode) async {
    String _couponCode = couponCode;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.only(top: 6),
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            insetPadding: EdgeInsets.symmetric(horizontal: 100),
            title: Text(
              "Coupons",
              textAlign: TextAlign.center,
            ),
            children: [
              SizedBox(
                height: 40,
                child: ListTile(
                  onTap: () {
                    claimCoupon();
                    Navigator.pop(context);
                  },
                  tileColor: Color(0xff001527),
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    _couponCode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              // ListView.builder(
              //   padding: EdgeInsets.symmetric(vertical: 6),
              //   shrinkWrap: true,
              //   itemCount: _showCouponModel!.data.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return InkWell(
              //       onTap: () async {
              //         setState(() {
              //           Coupontext = _showCouponModel!.data[index].couponCode;
              //           Couponid = _showCouponModel!.data[index].id;
              //         });
              //
              //         await claimCoupon();
              //         Fluttertoast.showToast(msg: _claimCouponModel!.message);
              //         Navigator.pop(context);
              //
              //       },
              //       child: SizedBox(
              //         height: 40,
              //         child: ListTile(
              //           tileColor: Color(0xffed1b24),
              //           dense: true,
              //           contentPadding: EdgeInsets.all(0),
              //           title: Text(_showCouponModel!.data[index].couponCode, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          );
        });
  }

  Future<ProductDetailsResponseModel?> getProduct() async {
    var token = await HelperFunction.getToken();
    var response =
        await Http.get(Uri.parse(productDetailsUrl + widget.id.toString()),headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    print(response.body);

    setState(() {
      _productDetailsResponseModel =
          ProductDetailsResponseModel.fromJson(jsonDecode(response.body));
    });
    print(
        "_productDetailsResponseModel++++++++++++${_productDetailsResponseModel!}");
    return _productDetailsResponseModel;
  }
  
  
  addFav() async{
    print(addFavUrl + widget.id.toString());
    try{
      var token = await HelperFunction.getToken();
      var response = await Http.post(Uri.parse(addFavUrl + widget.id.toString()), headers: {
        'Authorization': 'Bearer $token'
      });

      print("favourite responce +++++++++ "+response.toString());
      var res = jsonDecode(response.body);
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res["message"])));
      }
    }
    catch (e){
      print(e);
      print("dasdasd12");
    }
  }

  removeFav() async{
    try{
      var token = await HelperFunction.getToken();
      var response = await Http.post(Uri.parse(removeFavUrl + widget.id.toString()), headers: {
        'Authorization': 'Bearer $token'
      });

      print("remove responce +++++++++ "+response.toString());
      var res = jsonDecode(response.body);
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res["message"])));
      }
    }
    catch (e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            // CustomAppBar("Product", IconButton(
            // onPressed: () {},
            // icon: Icon(
            // CupertinoIcons.ellipsis_vertical,
            // color: Colors.white,
            // ),
            // ),),
            PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xfff8faf7),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: Color(0xff001527),
                      ),
                    ),
                    Text(
                      _productDetailsResponseModel!=null?_productDetailsResponseModel!.data.productName:"",
                      softWrap: true,
                      style: TextStyle(color: Color(0xff001527), fontSize: 22,overflow: TextOverflow.ellipsis),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.ellipsis_vertical,
                        color: Color(0xff001527),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: Provider.of<InternetConnectionStatus>(context) == InternetConnectionStatus.disconnected,
                child: InternetNotAvailable()),
            _productDetailsResponseModel != null
                ? Slider()
                : Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      height: 250,
                      color: Colors.white,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            _productDetailsResponseModel != null
                ? bodyWidget()
                : Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: 20, width: 80, color: Colors.white),
                                SizedBox(
                                  width: 55,
                                ),
                                Container(
                                    height: 20, width: 80, color: Colors.white),
                              ]),
                          sizeBox(),
                          Container(
                              height: 22,
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: Colors.white),
                          sizeBox(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            color: Colors.white,
                          ),
                          sizeBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          sizeBox(),
                          Container(
                            width: 150,
                            height: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: 20,
                            width: 70,
                            color: Colors.white,
                          ),
                          sizeBox(),
                          sizeBox()
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      )),
    );
  }




  Widget sizeBox() {
    return SizedBox(
      height: 12,
    );
  }

  CarouselController buttonCarouselController = CarouselController();

  // List<String> images = [
  //   "https://images.pexels.com/photos/19090/pexels-photo.jpg?cs=srgb&dl=pexels-web-donut-19090.jpg&fm=jpg",
  //   "https://images.pexels.com/photos/19090/pexels-photo.jpg?cs=srgb&dl=pexels-web-donut-19090.jpg&fm=jpg",
  //   "https://images.pexels.com/photos/19090/pexels-photo.jpg?cs=srgb&dl=pexels-web-donut-19090.jpg&fm=jpg",
  // ];

  int itemIndex = 0;
  // bool isFav = _productDetailsResponseModel!.data.favorites;
  Widget Slider() {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: buttonCarouselController,
          itemCount: _productDetailsResponseModel!.data.images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            height: 100,
            width: 100,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                  "https://dealsbuck.com/" +
                      _productDetailsResponseModel!
                          .data.images[itemIndex].productImagePath,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrase) {
                return Image.asset(
                  "assets/defaultImage.png",
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
          options: CarouselOptions(
            height: 250.0,
            onPageChanged: (index, pageViewIndex) {
              setState(() {
                itemIndex = index;
              });
            },
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.95,
          ),
        ),
        Positioned(
          bottom: 5,
          left: 0,
          right: 0,
          child: Center(
            child: CarouselIndicator(
              width: 6,
              height: 6,
              space: 15,
              count: _productDetailsResponseModel!.data.images.length,
              index: itemIndex,
              activeColor: Color(0xffed1b24),
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.1,
            child: InkWell(
              onTap: (){
                setState(() {
                  _productDetailsResponseModel!.data.favorites = !_productDetailsResponseModel!.data.favorites;
                  if(_productDetailsResponseModel!.data.favorites){
                    addFav();
                  }
                  else{
                    removeFav();
                  }
                });
              },
          child: _productDetailsResponseModel!.data.favorites? Icon(Icons.favorite, color: Color(0xffed1b24),): Icon(Icons.favorite_border,),
        ))
      ],
    );
  }


  Widget bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 17,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    _productDetailsResponseModel!.data.avgRating!= null?"${double.parse(_productDetailsResponseModel!.data.avgRating).toStringAsFixed(1)} Rates":"0 Rates",
                    style: TextStyle(fontSize: 12, color: Color(0xff001527)),
                  )
                ],
              ),
              SizedBox(
                width: 55,
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.tag_fill,
                    color: Color(0xffed1b24),
                    size: 12,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "₹${_productDetailsResponseModel!.data.price}",
                    style: TextStyle(fontSize: 12, color: Color(0xff001527)),
                  )
                ],
              )
            ],
          ),
          sizeBox(),
          Text(
            _productDetailsResponseModel!.data.productName,
            style: TextStyle(
                color: Color(0xff001527),
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
          sizeBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Select Outlet",
                style: TextStyle(
                    color: Color(0xff001527),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: BorderSide(color: Color(0xffed1b24), width: 1),
                      backgroundColor: Colors.white,
                      // fixedSize: Size(100, 40),
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10)),
                  onPressed: () {},
                  child: Text(
                    _productDetailsResponseModel!.data.city,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xffed1b24),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          sizeBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Deals Terms & Conditions",
                        style: TextStyle(
                            color: Color(0xff001527),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("1. Demo"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("2. Guaranted"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("3. Custom Shoelace"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("4. Free Shipping"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("5. Comfortable"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("6. Custom Shoelace"),
                  ],
                ),
              ],
            ),
          ),
          sizeBox(),
          Coupontext == "" ? Container() : Text("Applied Coupon: $Coupontext"),
          sizeBox(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xffed1b24), width: 1),
                  fixedSize: Size(150, 40),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10)),
              onPressed: () {
                // showCouponMenu();
                _askedToLead(_productDetailsResponseModel!.data.couponCode);
              },
              child: Text(
                "Redeem Now",
                style: TextStyle(
                    color: Color(0xffed1b24),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 3,
          ),
          sizeBox()
        ],
      ),
    );
  }




}
