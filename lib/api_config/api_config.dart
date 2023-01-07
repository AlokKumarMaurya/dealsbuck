import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../location_getter/get_usser_current_location.dart';
import '../model/category/category_product_product_modal.dart';
import '../model/category/particular_category_list.dart';
import '../model/get_user_personl_detail/get_personal_detail_modal.dart';
import '../model/popular_brand/paroduct_detal_modal.dart';
import '../model/popular_brand/particular_brand_list.dart';
import '../utils/urlsConstant.dart';

class ApiConfig extends GetConnect {
  GetUserCurrentLocaton _getUserCurrentLocaton =
      Get.put(GetUserCurrentLocaton());

  getParticularBrandList(String brandId) async {
    var response = await get("$showPopularBarndDataList/$brandId");
    try {
      if (response != null) {
        ParticularBrandList modal =
            ParticularBrandList.fromJson((response.body));
        return modal;
      }
    } catch (e) {
      debugPrint(e.toString());
      // Get.showSnackbar(GetSnackBar(messageText: Text(e.toString()),duration: Duration(seconds: 2),));
    }
  }

  getParticularCategoryList(String id) async {
    try {
      var response = await get(
          "$getCategoryDataList$id/${_getUserCurrentLocaton.lat.value}/${_getUserCurrentLocaton.long.value}");
      debugPrint(
          "$getCategoryDataList$id/${_getUserCurrentLocaton.lat.value}/${_getUserCurrentLocaton.lat.value}");
      if (response != null) {
        ParticularCategoryList modal =
            ParticularCategoryList.fromJson((response.body));
        return modal;
      }
    } catch (e) {
      debugPrint(e.toString());
      // Get.showSnackbar(GetSnackBar(messageText: Text(e.toString()),duration: Duration(seconds: 2),));
    }
  }

  getParticularPopularProductDetail(String id) async {
    try {
      var response = await get("$getParticularPopularProductDetailApi$id");
      debugPrint("$getParticularPopularProductDetailApi/$id");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        PopulareBrandParticularProductDeatil modal =
            PopulareBrandParticularProductDeatil.fromJson(response.body);
        debugPrint(response.statusCode.toString());
        return modal;
      }
    } catch (e) {
      debugPrint(e.toString());
      // Get.showSnackbar(GetSnackBar(messageText: Text(e.toString()),duration: Duration(seconds: 2),));
    }
  }

  categoryParticularCategoryProductDetail(String Catid, String proId) async {
    try {
      debugPrint("$categoryParticularCategoryProductDetailApi$Catid/$proId");
      var response =
          await get("$categoryParticularCategoryProductDetailApi$Catid/$proId");
      // debugPrint("$getParticularPopularProductDetailApi/$id");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        CategoryProductProductDeatilModal modal =
            CategoryProductProductDeatilModal.fromJson(response.body);
        debugPrint(response.statusCode.toString());
        return modal;
      }
    } catch (e) {
      debugPrint(e.toString());
      // Get.showSnackbar(GetSnackBar(messageText: Text(e.toString()),duration: Duration(seconds: 2),));
    }
  }


  getPersonalDetailOfUser()async{
    var token=await HelperFunction.getToken();
    debugPrint("y3uyr884ry73y78r3r34r");
    debugPrint(token.toString());
    try{
      var response=await get(getPersonalDetailUrl,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      debugPrint("34863646343473477367463746736476743");
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      if(response.statusCode==200){
        GetUserPersonalDetailModal modal=GetUserPersonalDetailModal.fromJson(response.body);
        debugPrint(modal.toString());
        return modal;
      }
    }catch(e){debugPrint(e.toString());}
  }
  
  
}
