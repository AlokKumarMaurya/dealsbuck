import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../location_getter/get_usser_current_location.dart';
import '../model/category/particular_category_list.dart';
import '../model/popular_brand/particular_brand_list.dart';
import '../utils/urlsConstant.dart';

class ApiConfig extends GetConnect{
  GetUserCurrentLocaton _getUserCurrentLocaton=Get.put(GetUserCurrentLocaton());
  getParticularBrandList(String brandId)async{

    var response=await get("$showPopularBarndDataList/$brandId");
    try{
      if(response !=null){
        ParticularBrandList modal=ParticularBrandList.fromJson((response.body));
        return modal;
      }
    }catch(e){
debugPrint(e.toString());
      Get.showSnackbar(GetSnackBar(messageText: Text(e.toString()),duration: Duration(seconds: 2),));}

  }

  getParticularCategoryList(String id)async{
    try{
      var response=await get("$getCategoryDataList$id/${_getUserCurrentLocaton.lat.value}/${_getUserCurrentLocaton.long.value}");
   debugPrint("$getCategoryDataList$id/${_getUserCurrentLocaton.lat.value}/${_getUserCurrentLocaton.lat.value}");
      if(response!=null){
     ParticularCategoryList modal=ParticularCategoryList.fromJson((response.body));
     return modal;
   }
    }catch(e){
      debugPrint(e.toString());
      Get.showSnackbar(GetSnackBar(messageText: Text(e.toString()),duration: Duration(seconds: 2),));}
  }
}