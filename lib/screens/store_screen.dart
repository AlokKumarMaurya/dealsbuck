import 'dart:async';
import 'package:dealsbuck/screens/popular_brand/popular_barnd_details_page.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import '../api_config/api_config.dart';
import '../location_getter/get_usser_current_location.dart';
import '../model/popularBrandsResponseModel.dart';
import '../model/popular_brand/particular_brand_list.dart';
import 'homeScreens/Recommended Screen/Product Screen/productScreen.dart';
import 'homeScreens/home_page_screen.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({Key? key, required this.popularBrandsResponseModel})
      : super(key: key);
  Datum popularBrandsResponseModel;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
                                      address![1],
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
                                          widget.popularBrandsResponseModel
                                              .brandImagePath,
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
                                          widget
                                              .popularBrandsResponseModel.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          widget.popularBrandsResponseModel
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
                    widget.popularBrandsResponseModel
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
               Text(widget.popularBrandsResponseModel.name,style: TextStyle(
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
                Text(widget.popularBrandsResponseModel
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

  void getData() async {
    var response = await ApiConfig().getParticularBrandList(
        widget.popularBrandsResponseModel.id.toString());
    if (response != null) {
      ParticularBrandList modal = response;
      dataList.value = modal.data.products;
      getAddrress(modal);
    }
  }

  void getAddrress(ParticularBrandList modal) async{
    await placemarkFromCoordinates(
        double.parse(modal.data.latitude), double.parse(modal.data.longitude))
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      long="${place.street},${place.subLocality},${place.locality},${place.administrativeArea},${place.country},${place.postalCode}";
  });
}







}