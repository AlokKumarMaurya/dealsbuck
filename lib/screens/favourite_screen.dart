import 'dart:convert';

import 'package:dealsbuck/screens/appBar.dart';
import 'package:dealsbuck/screens/homeScreens/Recommended%20Screen/Product%20Screen/productScreen.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as Http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../model/getFavResponseModel.dart';
import '../utils/internetNotConnected.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  GetFavModel? _getFavModel;

  Future<GetFavModel?> getfav() async {
    var token = await HelperFunction.getToken();
    try {
      var response = await http.get(Uri.parse(getFavUrl),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        setState(() {
          _getFavModel = GetFavModel.fromJson(jsonDecode(response.body));
        });
        return _getFavModel;
      }
    } catch (e) {
      print(e);
    }
  }

  removeFav(id) async {
    try {
      var token = await HelperFunction.getToken();
      var response = await Http.post(Uri.parse(removeFavUrl + id.toString()),
          headers: {'Authorization': 'Bearer $token'});

      print("remove responce +++++++++ " + response.toString());
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res["message"])));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getfav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("00000000000000000000000000000000000=-===============");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: VisibilityDetector(
                  key: Key('my-widget-key'),
                  onVisibilityChanged: (visibilityInfo) {
debugPrint("009090909090909090909090909090909090909090");
                    getfav();
                    var visiblePercentage = visibilityInfo.visibleFraction * 100;
                    debugPrint(
                        'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                  },
                  child: CustomAppBar("Favourite", Container(), Container())),
            ),
            _getFavModel != null
                ? bodyWidget()
                : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyWidget() {
    return Column(
      children: [
        Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: InternetNotAvailable()),
        (_getFavModel!.data.length != 0 && !_getFavModel!.data.length.isNull)
            ? SingleChildScrollView(
            child: ListView.builder(
                itemCount: _getFavModel!.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductScreen(
                                      id: _getFavModel!.data[index].id)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade300
                        ),
                        child: Row(
                            children: [
                        SizedBox(width: MediaQuery.of(context).size.width /
                            44,),
                      CircleAvatar(
                        radius: 35,
                        backgroundImage:NetworkImage(
                          "https://dealsbuck.com/${_getFavModel!.data[index]
                              .featuredImagePath}"),
                      ),
                      SizedBox(width: MediaQuery
                          .of(context)
                          .size
                          .width / 44,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:MediaQuery.of(context).size.width/3.5,
                            // color: Colors.pink,
                            child: Text(_getFavModel!.data[index].name, style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          SizedBox(height: 3,),
                          Container(
                            width: MediaQuery.of(context).size.width/3.5,
                            // color: Colors.pink,
                            child: Text(_getFavModel!.data[index].description,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                )),
                          ),
                          SizedBox(height: 3,),
                          Container(
                            width: MediaQuery.of(context).size.width/3.5,
                            child: Text(_getFavModel!.data[index].specification,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                )),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery
                          .of(context)
                          .size
                          .width / 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Price", style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                          Text("₹ " + _getFavModel!.data[index].price,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ))
                        ],
                      ),
                      IconButton(
                    icon:  !_getFavModel!.data.contains(
                          _getFavModel!.data[index].id)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      color: Color(0xffC60808),
                      onPressed: () {
                        removeFav(_getFavModel!.data[index].id);
                        getfav();
                      },
                    )
                    ],
                  ),)
                  ,
                  )
                  ,
                  );
                }))
            : Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 1.5,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no_data_found.jfif"),
              SizedBox(
                height: 15,
              ),
              Text(
                "Sorry No record found",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }
}


//
// Card(
// elevation: 5,
// child: ListTile(
// leading:Container(
// // height: ,\
// height: 50,
// width: 50,
// decoration: BoxDecoration(
// // borderRadius: BorderRadius.circular(20),
// shape: BoxShape.circle
// ),
// child: Image.network("https://dealsbuck.com/${_getFavModel!.data[index].featuredImagePath}",fit: BoxFit.fill,),
// ),
// title: Text(_getFavModel!.data[index].name),
// subtitle: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// _getFavModel!.data[index].description,
// style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 5,),
// Text("₹ "+_getFavModel!.data[index].price),
// ],
// ),
// trailing: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text(
// "Dine - in Daily",
// style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold),
// ),
// Container(
// margin: EdgeInsets.all(5),
// padding:
// EdgeInsets.symmetric(horizontal: 5),
// height: 20,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(15),
// color: Colors.black),
// child: ListView.builder(
// scrollDirection: Axis.horizontal,
// shrinkWrap: true,
// physics:
// NeverScrollableScrollPhysics(),
// itemCount: 5,
// itemBuilder:
// (BuildContext contex, int index) {
// return Icon(
// Icons.star,
// color: Colors.orange,
// size: 18,
// );
// }),
// )
// ],
// ),
// IconButton(
// icon: !_getFavModel!.data.contains(
// _getFavModel!.data[index].id)
// ? Icon(Icons.favorite)
// : Icon(Icons.favorite_border),
// color: Color(0xffC60808),
// onPressed: () {
// removeFav(_getFavModel!.data[index].id);
// getfav();
// },
// )
// ],
// ),
// tileColor: Colors.white,
// ),
// )