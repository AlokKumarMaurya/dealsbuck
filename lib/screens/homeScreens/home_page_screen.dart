import 'dart:convert';
import 'dart:io';

import 'package:dealsbuck/model/nearByDealsResponseModel.dart';
import 'package:dealsbuck/model/topDealsResponseModel.dart';
import 'package:dealsbuck/screens/drawer_screen.dart';
import 'package:dealsbuck/screens/homeScreens/homeScreen_controller.dart';
import 'package:dealsbuck/screens/homeScreens/search_widget.dart';


import 'package:dealsbuck/utils/internetNotConnected.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:dealsbuck/model/bannerResponseModel.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../location_getter/get_usser_current_location.dart';
import '../../model/categoriesResponseModel.dart';
import '../../model/popularBrandsResponseModel.dart';

import '../products_grid_list.dart';
import '../store_screen.dart';
import '../subCategory.dart';
import 'Recommended Screen/Product Screen/productScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
List? address;
class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  CarouselController buttonCarouselController = CarouselController();
  final homeController = Get.put(HomeController());
  GetUserCurrentLocaton _getLocaton=Get.put(GetUserCurrentLocaton());
  int itemIndex = 0;
  CategoriesModel? _categoriesModel;
  TopDealsModel? _topDealsModel;
  NearByDealsModel? _nearByDealsModel;
  PopularBrandsResponseModel? _popularBrandsResponseModel;

  //int simpleIntInput = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? _currentAddress;
  Position? _currentPosition;

void refresh(bool test){
  print("homeController.isSearch.value");
  if(test){
    getPopularBrands();
    _getCurrentPosition();
    getbanner();
    getcategories();
    getTopDeals();
    getNearByDeals();

  }

}


  void initState() {
    print(homeController.isSearch.value);
    _getCurrentPosition().then((value) => refresh(true));
    _getLocaton.getLocation().then((val)=>refresh(true));
    getbanner();
    getcategories();
    getTopDeals();
    getNearByDeals();
    getPopularBrands();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    final homeController = Get.put(HomeController());
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("djdidjwi");
    if (!serviceEnabled) {
      print("sdasdasda");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Location services are disabled. Please enable the services")));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SystemNavigator.pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permissions are denied")));
        _getCurrentPosition();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<bool> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return false;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        HelperFunction.saveLongitude(_currentPosition!.longitude.toString());
        HelperFunction.saveLatitude(_currentPosition!.latitude.toString());
      } );
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    print("${_currentPosition!.latitude}");
    print("${_currentPosition!.longitude}");
    print("getLongitude>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${await HelperFunction.getLongitude()}");
    print("getLatitude>>>>>>>>>>>>>>>>>>>>>>>>>>>>${await HelperFunction.getLatitude()}");
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _getLocaton.lat.value, _getLocaton.long.value)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        address = [
          '${place.street}',
          '${place.subLocality}',
          '${place.subAdministrativeArea}',
          '${place.postalCode}'
        ];
        print("addressssss>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$_currentAddress");
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<BannerModel?> getbanner() async {
    var response = await Http.get(Uri.parse(bannerUrl));
    print(response.body);
    print(await HelperFunction.getToken());
    setState(() {
      _bannerModel = BannerModel.fromJson(jsonDecode(response.body));
    });

    print("_bannerModel${_bannerModel!}");
    return _bannerModel;
  }

  Future<CategoriesModel?> getcategories() async {
    var response = await Http.get(Uri.parse(categoriesUrl));
    print(response.body);
    setState(() {
      _categoriesModel = CategoriesModel.fromJson(jsonDecode(response.body));
    });
    print("_categoriesModel${_categoriesModel!}");
    return _categoriesModel;
  }

  Future<TopDealsModel?> getTopDeals() async {
    print("222222222222222222222222222222222");
    var response = await Http.get(Uri.parse(topDealsUrl+"${_getLocaton.lat.value}/${_getLocaton.long.value}"));
    print(response.body);
var temp=jsonDecode(response.body);
var message=temp["message"];
    setState(() {
      if(message !="No Top Deals")
      _topDealsModel = TopDealsModel.fromJson(jsonDecode(response.body));
    });

    return _topDealsModel;
  }

  Future<NearByDealsModel?> getNearByDeals() async {
    var response = await Http.get(Uri.parse(nearByDealsUrl+"${_getLocaton.lat.value}/${_getLocaton.long.value}"));
    print(response.body);
    var temp=jsonDecode(response.body);
    var message=temp["message"];
    setState(() {
      if(message != "No Nearby Deals")
      _nearByDealsModel = NearByDealsModel.fromJson(jsonDecode(response.body));
    });
    return _nearByDealsModel;
  }

  Future<PopularBrandsResponseModel?> getPopularBrands() async {
    var response = await Http.get(Uri.parse(popularBrandsUrl+"${_getLocaton.lat.value}/${_getLocaton.long.value}"));
    print(response.body);

    setState(() {
      _popularBrandsResponseModel =
          PopularBrandsResponseModel.fromJson(jsonDecode(response.body));
    });
    print("_popularBrandsResponseModel++++++${_popularBrandsResponseModel!}");
    return _popularBrandsResponseModel;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return exit(0);
      },
      child: Scaffold(
          backgroundColor: Color(0xffF3F6F9),
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: Container(
                padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffed1b24),
                        blurRadius: 5.0,
                        offset: Offset(0, 2)),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            //color: Colors.black,
                            height: 40,
                            child: Image.asset(
                              "assets/dealbuckText.png",
                              fit: BoxFit.fitWidth,
                              width: 120,
                              height: 50,
                            )),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  _getLocaton.searchLoacation().then((r)=>refresh(true));
                                  _getLocaton.getLocation();
                                  refresh(true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xff001527),
                                          content:
                                              Text("Location Updated")));
                                },
                                child: Icon(
                                  Icons.place_outlined,
                                  color: Color(0xff001527),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            address != null
                                ? Text(
                                    address![1].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                        fontSize: 18,
                                        color: Color(0xff001527),
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(""),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.transparent,
                                ),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      CupertinoIcons.chevron_down,
                                      size: 18,
                                      color: Color(0xffed1b24),
                                    ))),
                          ],
                        ),
                      ],
                    ),
                    SearchBox(contextt: context,),
                  ],
                )),
          ),
          body: RefreshIndicator(
            onRefresh:() async{
                  refresh(true);
            } ,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Visibility(
                      visible: Provider.of<InternetConnectionStatus>(context) == InternetConnectionStatus.disconnected,
                      child: InternetNotAvailable()),
                  SizedBox(height: 15),

                  _bannerModel != null
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Slider(),
                  )
                      : Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      height: 150,
                      color: Colors.white,
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        _categoriesModel != null ? Categories() : shimmer(),
                        SizedBox(height: 5),
                        _topDealsModel != null ? Recommended() : shimmer(),
                        SizedBox(height: 5),
                        _nearByDealsModel != null ? NearByDeals() : shimmer(),
                        SizedBox(height: 5),
                        _popularBrandsResponseModel != null
                            ? PopularDeals()
                            : shimmer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: DrawerScreen()),
    );
  }

  Widget Categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff001527)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductsGridListScreen(title: 'Categories', nearByDealsModel: _nearByDealsModel!, topDealsModel: _topDealsModel!, categoriesModel: _categoriesModel!)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: Text(
                  "View More",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 2.1,
                crossAxisSpacing: 0,
                crossAxisCount: 4),
            itemCount: _categoriesModel?.data.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubCategory(id: _categoriesModel!.data[index].id,title: _categoriesModel!.data[index].name,)));
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
                        child: Image.network("https://dealsbuck.com/" +
                            _categoriesModel!.data[index].imagePath,
                          errorBuilder: (BuildContext context,Object exception, StackTrace? stackTrase){
                            return Image.asset("assets/defaultImage.png", fit: BoxFit.cover,);
                          },),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        _categoriesModel!.data[index].name,
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

  Widget Recommended() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Top Deals",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff001527)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductsGridListScreen(title: 'TopDeals', nearByDealsModel: _nearByDealsModel!, topDealsModel: _topDealsModel!, categoriesModel: _categoriesModel!)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: Text(
                  "View More",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
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
              itemCount: _topDealsModel!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductScreen(
                                  id: _topDealsModel!.data![index].id!,
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
                                    _topDealsModel!
                                        .data![index].featuredImagePath!,
                                fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context,Object exception, StackTrace? stackTrase){
                                    return Image.asset("assets/defaultImage.png", fit: BoxFit.cover,);
                                  }
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 2,
                          // ),
                          Text(
                            _topDealsModel!.data![index].productName!,
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
                          /*Text(
                widget.recommendedDatas.text2,
                style: TextStyle(fontSize: 15),
              ),*/
                          // SizedBox(
                          //   height: 2,
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _topDealsModel!.data![index].description!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9.9,
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

  Widget NearByDeals() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Nearby Deals",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff001527)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductsGridListScreen(title: 'Nearby Deals', nearByDealsModel: _nearByDealsModel!, topDealsModel: _topDealsModel!, categoriesModel: _categoriesModel!)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(
                  "View More",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
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
              itemCount: _nearByDealsModel!.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductScreen(
                                  id: _nearByDealsModel!.data[index].id,
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
                                    _nearByDealsModel!
                                        .data[index].featuredImagePath,
                                fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context,Object exception, StackTrace? stackTrase){
                                    return Image.asset("assets/defaultImage.png", fit: BoxFit.cover,);
                                  }
                              ),
                            ),
                          ),
                          Text(
                            _nearByDealsModel!.data[index].productName,
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
                              _nearByDealsModel!.data[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9.9,
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

  Widget PopularDeals() {
    return (_popularBrandsResponseModel!.data.length!=0)?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Brands",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff001527)),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 18,
                  crossAxisCount: 4),
              itemCount: _popularBrandsResponseModel!.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(_popularBrandsResponseModel!.data[index].id.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopScreen(popularBrandsResponseModel: _popularBrandsResponseModel!.data[index])));
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://dealsbuck.com/" +
                            _popularBrandsResponseModel!
                                .data[index].brandImagePath,
                        fit: BoxFit.fill,
                          errorBuilder: (BuildContext context,Object exception, StackTrace? stackTrase){
                            return Image.asset("assets/defaultImage.png", fit: BoxFit.cover,);
                          }
                      ),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "View More",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    ):Container();
  }

  BannerModel? _bannerModel;

  Widget Slider() {
    return CarouselSlider.builder(
      carouselController: buttonCarouselController,
      itemCount: _bannerModel!.data.isNotEmpty ? _bannerModel!.data.length : 0,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(10.0),child:Image.network(Bannerimages[itemIndex],fit: BoxFit.fitWidth,),
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            "https://dealsbuck.com/" +
                _bannerModel!.data[itemIndex].bannerImagePath,
            fit: BoxFit.fitWidth,
            errorBuilder: (BuildContext context,Object exception, StackTrace? stackTrase){
              return Image.asset("assets/defaultImage.png", fit: BoxFit.fitWidth,);
            },
          ),
        ),
      ),
      options: CarouselOptions(
        height: 150.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.90,
      ),
    );
  }
}

Widget shimmer() {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Container(
              height: 18,
              width: 80,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 2.1,
                  crossAxisSpacing: 0,
                  crossAxisCount: 4),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 57,
                      width: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        height: 12,
                        width: 58,
                        color: Colors.white,
                      ),
                    )
                  ],
                );
              }),
        ],
      ));
}
