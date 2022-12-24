// import 'dart:convert';
//
// import 'package:carousel_indicator/carousel_indicator.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dealsbuck/api_config/api_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../model/category/category_product_product_modal.dart';
// import '../../model/claimCouponResponseModel.dart';
// import '../../model/popular_brand/paroduct_detal_modal.dart';
// import '../../utils/internetNotConnected.dart';
// import '../../utils/sharedPreference.dart';
// import 'package:http/http.dart' as Http;
//
// import '../../utils/urlsConstant.dart';
//
// class CategoryProductProductDetailsPage extends StatefulWidget {
//   String catid;
//   String proid;
//   String title;
//   CategoryProductProductDetailsPage({Key? key,required this.catid,required this.proid,required this.title}) : super(key: key);
//
//   @override
//   State<CategoryProductProductDetailsPage> createState() => _CategoryProductProductDetailsPageState();
// }
//
// class _CategoryProductProductDetailsPageState extends State<CategoryProductProductDetailsPage> {
//   CategoryProductProductDeatilModal? _populareBrandParticularProductDeatil;
//   String Coupontext = "";
//   ClaimCouponModel? _claimCouponModel;
//
//   @override
//   void initState() {
//     getData();
//     // TODO: implement initState
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // CustomAppBar("Product", IconButton(
//                 // onPressed: () {},
//                 // icon: Icon(
//                 // CupertinoIcons.ellipsis_vertical,
//                 // color: Colors.white,
//                 // ),
//                 // ),),
//                 PreferredSize(
//                   preferredSize: Size.fromHeight(80.0),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     width: MediaQuery.of(context).size.width,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Color(0xfff8faf7),
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.arrow_back_sharp,
//                             color: Color(0xff001527),
//                           ),
//                         ),
//                         Text(
//                           widget.title,
//                           softWrap: true,
//                           style: TextStyle(color: Color(0xff001527), fontSize: 22,overflow: TextOverflow.ellipsis),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             CupertinoIcons.ellipsis_vertical,
//                             color: Color(0xff001527),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                     visible: Provider.of<InternetConnectionStatus>(context) == InternetConnectionStatus.disconnected,
//                     child: InternetNotAvailable()),
//                 _populareBrandParticularProductDeatil != null && _populareBrandParticularProductDeatil!.data
//                     ? Slider()
//                     : Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,
//                   child: Container(
//                     margin: EdgeInsets.only(left: 20, right: 20),
//                     //decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                     height: 250,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _populareBrandParticularProductDeatil != null
//                     ? bodyWidget()
//                     : Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Column(
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Container(
//                                   height: 20, width: 80, color: Colors.white),
//                               SizedBox(
//                                 width: 55,
//                               ),
//                               Container(
//                                   height: 20, width: 80, color: Colors.white),
//                             ]),
//                         sizeBox(),
//                         Container(
//                             height: 22,
//                             width: MediaQuery.of(context).size.width * 0.8,
//                             color: Colors.white),
//                         sizeBox(),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           height: 50,
//                           color: Colors.white,
//                         ),
//                         sizeBox(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     height: 200,
//                                     width: MediaQuery.of(context).size.width *
//                                         0.75,
//                                     color: Colors.white,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         sizeBox(),
//                         Container(
//                           width: 150,
//                           height: 40,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 3,
//                         ),
//                         Container(
//                           height: 20,
//                           width: 70,
//                           color: Colors.white,
//                         ),
//                         sizeBox(),
//                         sizeBox()
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
//
//   void getData() async{
//     debugPrint("1111111111111111111111111111111");
//     var response =await ApiConfig().categoryParticularCategoryProductDetail(widget.catid,widget.proid);
//     debugPrint("1111111111111111111111111111111");
//     debugPrint(response.toString());
//     if(response!=null){
//       debugPrint("1111111111111111111111111111111");
//       setState(() {
//         _populareBrandParticularProductDeatil=response;
//       });
//       // debugPrint(_populareBrandParticularProductDeatil!.data.productName.toString());
//     }
//   }
//
//   Widget sizeBox() {
//     return SizedBox(
//       height: 12,
//     );
//   }
//
//   int itemIndex = 0;
//
//   CarouselController buttonCarouselController = CarouselController();
//
//
//   Widget Slider() {
//     return Stack(
//       children: [
//         CarouselSlider.builder(
//           carouselController: buttonCarouselController,
//           itemCount: _populareBrandParticularProductDeatil!.data.images.length,
//           itemBuilder:
//               (BuildContext context, int itemIndex, int pageViewIndex) =>
//               Container(
//                 height: 100,
//                 width: 100,
//                 child: FittedBox(
//                   fit: BoxFit.cover,
//                   child: Image.network(
//                       "https://dealsbuck.com/" +
//                           _populareBrandParticularProductDeatil!
//                               .data.images[itemIndex].productImagePath,
//                       errorBuilder: (BuildContext context, Object exception,
//                           StackTrace? stackTrase) {
//                         return Image.asset(
//                           "assets/defaultImage.png",
//                           fit: BoxFit.cover,
//                         );
//                       }),
//                 ),
//               ),
//           options: CarouselOptions(
//             height: 250.0,
//             onPageChanged: (index, pageViewIndex) {
//               setState(() {
//                 itemIndex = index;
//               });
//             },
//             enlargeCenterPage: true,
//             autoPlay: true,
//             aspectRatio: 16 / 9,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             viewportFraction: 0.95,
//           ),
//         ),
//         Positioned(
//           bottom: 5,
//           left: 0,
//           right: 0,
//           child: Center(
//             child: CarouselIndicator(
//               width: 6,
//               height: 6,
//               space: 15,
//               count: _populareBrandParticularProductDeatil!.data.images.length,
//               index: itemIndex,
//               activeColor: Color(0xffed1b24),
//               color: Colors.grey,
//             ),
//           ),
//         ),
//         // Positioned(
//         //     top: MediaQuery.of(context).size.width*0.05,
//         //     right: MediaQuery.of(context).size.width*0.1,
//         //     child: InkWell(
//         //       onTap: (){
//         //         setState(() {
//         //           _populareBrandParticularProductDeatil!.data = !_productDetailsResponseModel!.data.favorites;
//         //           if(_productDetailsResponseModel!.data.favorites){
//         //             addFav();
//         //           }
//         //           else{
//         //             removeFav();
//         //           }
//         //         });
//         //       },
//         //       child: _populareBrandParticularProductDeatil!.data.favorites? Icon(Icons.favorite, color: Color(0xffed1b24),): Icon(Icons.favorite_border,),
//         //     ))
//       ],
//     );
//   }
//
//   Widget bodyWidget() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.star,
//                     color: Colors.orangeAccent,
//                     size: 17,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     _populareBrandParticularProductDeatil!.data.avgRating!= null?"${double.parse(_populareBrandParticularProductDeatil!.data.avgRating).toStringAsFixed(1)} Rates":"0 Rates",
//                     style: TextStyle(fontSize: 12, color: Color(0xff001527)),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 width: 55,
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     CupertinoIcons.tag_fill,
//                     color: Color(0xffed1b24),
//                     size: 12,
//                   ),
//                   SizedBox(
//                     width: 12,
//                   ),
//                   Text(
//                     "₹${_populareBrandParticularProductDeatil!.data.price}",
//                     style: TextStyle(fontSize: 12, color: Color(0xff001527)),
//                   )
//                 ],
//               )
//             ],
//           ),
//           sizeBox(),
//           Text(
//             _populareBrandParticularProductDeatil!.data.productName??"",
//             style: TextStyle(
//                 color: Color(0xff001527),
//                 fontSize: 22,
//                 fontWeight: FontWeight.w500),
//           ),
//           sizeBox(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 "Select Outlet",
//                 style: TextStyle(
//                     color: Color(0xff001527),
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500),
//               ),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       side: BorderSide(color: Color(0xffed1b24), width: 1),
//                       backgroundColor: Colors.white,
//                       // fixedSize: Size(100, 40),
//                       padding: const EdgeInsets.fromLTRB(20, 10, 10, 10)),
//                   onPressed: () {},
//                   child: Text(
//                     _populareBrandParticularProductDeatil!.data.city,
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         color: Color(0xffed1b24),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   )),
//             ],
//           ),
//           sizeBox(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text("Deals Terms & Conditions",
//                         style: TextStyle(
//                             color: Color(0xff001527),
//                             fontSize: 17,
//                             fontWeight: FontWeight.w500,
//                             decoration: TextDecoration.underline)),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text("1. Demo"),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("2. Guaranted"),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("3. Custom Shoelace"),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("4. Free Shipping"),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("5. Comfortable"),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("6. Custom Shoelace"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           sizeBox(),
//           Coupontext == "" ? Container() : Text("Applied Coupon: $Coupontext"),
//           sizeBox(),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0)),
//                   backgroundColor: Colors.white,
//                   side: BorderSide(color: Color(0xffed1b24), width: 1),
//                   fixedSize: Size(150, 40),
//                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10)),
//               onPressed: () {
//                 // showCouponMenu();
//                 _askedToLead(_populareBrandParticularProductDeatil!.data.couponCode);
//               },
//               child: Text(
//                 "Redeem Now",
//                 style: TextStyle(
//                     color: Color(0xffed1b24),
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold),
//               )),
//           SizedBox(
//             height: 3,
//           ),
//           sizeBox()
//         ],
//       ),
//     );
//   }
//
//
//   Future<void> _askedToLead(String couponCode) async {
//     String _couponCode = couponCode;
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             titlePadding: EdgeInsets.only(top: 6),
//             contentPadding: EdgeInsets.symmetric(vertical: 0),
//             insetPadding: EdgeInsets.symmetric(horizontal: 100),
//             title: Text(
//               "Coupons",
//               textAlign: TextAlign.center,
//             ),
//             children: [
//               SizedBox(
//                 height: 40,
//                 child: ListTile(
//                   onTap: () {
//                     claimCoupon();
//                     Navigator.pop(context);
//                   },
//                   tileColor: Color(0xff001527),
//                   dense: true,
//                   contentPadding: EdgeInsets.all(0),
//                   title: Text(
//                     _couponCode,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//               // ListView.builder(
//               //   padding: EdgeInsets.symmetric(vertical: 6),
//               //   shrinkWrap: true,
//               //   itemCount: _showCouponModel!.data.length,
//               //   itemBuilder: (BuildContext context, int index) {
//               //     return InkWell(
//               //       onTap: () async {
//               //         setState(() {
//               //           Coupontext = _showCouponModel!.data[index].couponCode;
//               //           Couponid = _showCouponModel!.data[index].id;
//               //         });
//               //
//               //         await claimCoupon();
//               //         Fluttertoast.showToast(msg: _claimCouponModel!.message);
//               //         Navigator.pop(context);
//               //
//               //       },
//               //       child: SizedBox(
//               //         height: 40,
//               //         child: ListTile(
//               //           tileColor: Color(0xffed1b24),
//               //           dense: true,
//               //           contentPadding: EdgeInsets.all(0),
//               //           title: Text(_showCouponModel!.data[index].couponCode, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
//               //         ),
//               //       ),
//               //     );
//               //   },
//               // ),
//             ],
//           );
//         });
//   }
//
//
//   Future<ClaimCouponModel?> claimCoupon() async {
//     var token = await HelperFunction.getToken();
//     print(token);
//     print(widget.id.toString());
//     Map data = {"product_id": widget.id.toString()};
//     var response =
//     await Http.post(Uri.parse(claimCouponUrl), body: data, headers: {
//       'Authorization': 'Bearer $token',
//       // 'Accept': 'application/json',
//       // 'Content-Type': 'application/json'
//     });
//     print("claim Coupon response+++++++++++++" + response.body);
//     print("response.statusCode${response.statusCode}");
//     setState(() {
//       _claimCouponModel = ClaimCouponModel.fromJson(jsonDecode(response.body));
//     });
//     var res = jsonDecode(response.body);
//     if (res["status"] == true) {
//       if (res["message"].toString() == "Coupon Already Claimed") {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Coupon Already Claimed"),
//           backgroundColor: Color(0xff001527),
//         ));
//         setState(() {
//           Coupontext = "";
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Coupon Claim Successfully"),
//           backgroundColor: Color(0xff001527),
//         ));
//         setState(() {
//           Coupontext = _claimCouponModel!.data.couponCode;
//         });
//       }
//     }
//     return _claimCouponModel;
//   }
//
// }





import 'dart:async';
import 'package:dealsbuck/screens/popular_brand/popular_barnd_details_page.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

import '../../api_config/api_config.dart';
import '../../location_getter/get_usser_current_location.dart';
import '../../model/category/category_product_product_modal.dart';
import '../homeScreens/home_page_screen.dart';

class CategoryProductProductDetailsPage extends StatefulWidget {
  CategoryProductProductDetailsPage({Key? key, required this.catid,required this.proid,required this.title})
      : super(key: key);
    String catid;
  String proid;
  String title;

  @override
  State<CategoryProductProductDetailsPage> createState() => _CategoryProductProductDetailsPageState();
}

class _CategoryProductProductDetailsPageState extends State<CategoryProductProductDetailsPage> {
  CategoryProductProductDeatilModal? _populareBrandParticularProductDeatil;

  RxList<Product> dataList = List<Product>.empty(growable: true).obs;
  bool isLoading = true;
  bool isDataPresent = true; ////api not implemented
  GetUserCurrentLocaton _getUserCurrentLocaton =
  Get.put(GetUserCurrentLocaton());
  var lat;
  var long;
  @override
  void initState() {
    getData();
    Timer(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/backGround.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      // CustomAppBar("Single Pizza Shop", Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              height: 40,
                              // width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.location_solid,
                                      color: Color(0xff001527),
                                    ),
                                    Text(
                                      "$address",
                                      style: TextStyle(

                                          color: Color(0xff001527),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.only(top: 60, right: 35, left: 35),
                        height: 45,
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "What are you looking for",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xffC60808),
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 130.0),
                      //   child: Center(child: Text("Offers & Deals",style:  TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)),
                      // ),
                    ],
                  ),
                ),
                (isLoading)
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : (isDataPresent)
                    ? Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.network(
                            "https://dealsbuck.com/" +
                                _populareBrandParticularProductDeatil!.data.brandImagePath,
                            height: 90,
                            width: 100,
                          ),
                          SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _populareBrandParticularProductDeatil!.data.brandName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                _populareBrandParticularProductDeatil!.data
                                    .brandName,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Open Now 10 am - 10 pm (Today)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff108038)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 20,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (BuildContext contex,
                                        int index) {
                                      return Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 18,
                                      );
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      child: TabBar(
                        labelColor: Color(0xff001527),
                        labelStyle:
                        TextStyle(fontWeight: FontWeight.bold),
                        indicatorColor: Color(0xffed1b24),
                        tabs: [
                          Tab(text: "Offers"),
                          Tab(text: "About")
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(children: [
                          offers(),
                          about(),
                        ]),
                      ),
                    ),
                  ],
                )
                    : Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/no_data_found.jfif",
                        scale: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sorry no data found",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                ),

                // DefaultTabController(
                //   length: 5,
                //   child: Scaffold(
                //     appBar: AppBar(
                //       bottom: const TabBar(
                //         tabs: [
                //           Tab(icon: Icon(Icons.music_note)),
                //           Tab(icon: Icon(Icons.music_video)),
                //           Tab(icon: Icon(Icons.camera_alt)),
                //           Tab(icon: Icon(Icons.grade)),
                //           Tab(icon: Icon(Icons.email)),
                //         ],
                //       ), // TabBar
                //       title: const Text('GeeksForGeeks'),
                //       backgroundColor: Colors.green,
                //     ), // AppBar
                //     body: const TabBarView(
                //       children: [
                //         Icon(Icons.music_note),
                //         Icon(Icons.music_video),
                //         Icon(Icons.camera_alt),
                //         Icon(Icons.grade),
                //         Icon(Icons.email),
                //       ],
                //     ), // TabBarView
                //   ), // Scaffold
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget offers() {
    debugPrint(dataList.value.length.toString());
    debugPrint("dataList.value.length.toString()");
    return Obx(() => (dataList.value == null || dataList.value.length == 0
        ? Container(
      height: 100,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/no_data_found.jfif",
            scale: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Sorry no data found",
            style: TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    )
        : ListView.builder(
        itemCount: dataList.value.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // Get.showSnackbar(GetSnackBar(
              //   backgroundColor: Colors.red,
              //   duration: Duration(seconds: 2),
              //   messageText: Text(
              //     "No api implemented",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ));
              Navigator.push(context,MaterialPageRoute(builder:
                  (context)=>
                  PopularBrandDetailsPage(id:dataList.value[index].id.toString(),title: dataList.value[index].productName,)));
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      blurRadius: 4.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(
                        imagePath + dataList.value[index].featuredImagePath,
                        width: MediaQuery.of(context).size.width * 0.20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.67,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataList.value[index].productName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: Color(0xffC60808),
                                  size: 16,
                                )
                              ],
                            ),
                            Text(
                              "Any Menu Item.",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "BUY 1 GET 1 FREE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffC60808)),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5),
                                  height: 14,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.black),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext contex, int index) {
                                        return Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 12,
                                        );
                                      }),
                                )
                              ],
                            ),
                            Text(
                              "Dine - in Only",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        })));
    ;

    /// as no api is integrated
  }

  Widget about() {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 20,),
            Image.network(
                "https://dealsbuck.com/" +
                    _populareBrandParticularProductDeatil!.data
                        .brandImagePath,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context,Object exception, StackTrace? stackTrase){
                  return Image.asset("assets/defaultImage.png", fit: BoxFit.cover,);
                }
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30,),
                Text("Brand : ",style: TextStyle(
                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                )),
                Text(_populareBrandParticularProductDeatil!.data.brandName,style: TextStyle(
                    color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                ),),
              ],
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30,),
                Text("Product name : ",style: TextStyle(
                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                )),
                Text(_populareBrandParticularProductDeatil!.data
                    .brandName,style: TextStyle(
                    color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                ),),
              ],
            ),


            SizedBox(height: 20,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30,),
                Text("Address : ",style: TextStyle(
                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                )),
                Expanded(
                  child: Text(long??"-",
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                    ),),
                ),
              ],
            ),
            SizedBox(height: 20,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30,),
                Text("Total Products : ",style: TextStyle(
                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                )),
                Expanded(
                  child: Text("${dataList.value.length}",
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                    ),),
                ),
              ],
            ),
            SizedBox(height: 350,)
            // SizedBox(
            //   height: 100,
            // ),
            // Image.asset(
            //   "assets/no_data_found.jfif",
            //   scale: 1,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   "Sorry no data found",
            //   style: TextStyle(
            //     fontSize: 22,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void getData() async{
    debugPrint("1111111111111111111111111111111");
    var response =await ApiConfig().categoryParticularCategoryProductDetail(widget.catid,widget.proid);
    debugPrint("1111111111111111111111111111111");
    debugPrint(response.toString());
    if(response!=null){
      debugPrint("1111111111111111111111111111111");
      setState(() {
        _populareBrandParticularProductDeatil=response;
        dataList.value=_populareBrandParticularProductDeatil!.data.products;
      });
      getAddrress(_populareBrandParticularProductDeatil!);
      debugPrint(_populareBrandParticularProductDeatil!.data.products.toString());
    }
  }


  void getAddrress(CategoryProductProductDeatilModal modal) async{
    await placemarkFromCoordinates(
        double.parse(modal.data.latitude), double.parse(modal.data.longitude))
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState((){
        long="${place.street},${place.subLocality},${place.locality},${place.administrativeArea},${place.country},${place.postalCode}";
      });
    });
  }







}