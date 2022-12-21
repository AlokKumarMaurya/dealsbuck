import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dealsbuck/model/SubCategoryResponseModel.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/claimCouponResponseModel.dart';
import '../../../../model/productDetailsModel.dart';

import '../../../../utils/internetNotConnected.dart';
import '../../../../utils/urlsConstant.dart';
import '../api_config/api_config.dart';
import '../model/category/particular_category_list.dart';

class SubCategory extends StatefulWidget {
  SubCategory({Key? key, required this.id, required this.title}) : super(key: key);
  final int id;
  final String title;

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  SubCategoryModel? _subCategoryModel;
  bool loader = true;
RxList<Vendor> dataList=List<Vendor>.empty(growable: true).obs;
  Future<SubCategoryModel?> getSubCategory() async{
    try{
      print("0000000212$_subCategoryModel");
      var response = await Http.get(Uri.parse(subCategoryUrl+widget.id.toString()));
      print("12121121${response.body}");
      if(response.statusCode == 200){
        setState((){
          _subCategoryModel = SubCategoryModel.fromJson(jsonDecode(response.body));
          loader = false;
        });
        print("0000000212$_subCategoryModel");
      }
      return _subCategoryModel;
    }catch(e){
      print(e);
    }

  }

  void initState() {
    getdata();
    getSubCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:  SingleChildScrollView(
            child: Column(
              children: [
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
                          widget.title,
                          style: TextStyle(color: Color(0xff001527), fontSize: 22),
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
                Obx(()=>((dataList.value.length!=0)?GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 2.1,
                        crossAxisSpacing: 0,
                        crossAxisCount: 4),
                    itemCount: dataList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          Get.showSnackbar(GetSnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                            messageText: Text(
                              "No api implemented",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width*0.2,
                              width: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network("https://dealsbuck.com/${dataList.value[index].brandImagePath}",
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
                                dataList.value[index].brandName,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff001527),
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      );
                    }):
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height-100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/no_data_found.jfif",scale: 1,),
                      SizedBox(height: 20,),
                      Text("Sorry no data found",style: TextStyle(fontSize: 22,),)
                    ],
                  ),))




                ),
              ],
            ),
          )));
  }

  void getdata() async{
    var response=await ApiConfig().getParticularCategoryList(widget.id.toString());
    if(response!=null){
      ParticularCategoryList modal=response;
      dataList.value=modal.data.vendors;
    }
  }
}
