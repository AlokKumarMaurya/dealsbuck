import 'package:dealsbuck/api_config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/get_user_personl_detail/get_personal_detail_modal.dart';

class GetPersonalDetailController extends GetxController{

  Rxn<GetUserPersonalDetailModal> userPersonalDetailModal=Rxn();



  @override
  void onInit() {
    getPersonalDetail();
    // TODO: implement onInit
    super.onInit();
  }

  void getPersonalDetail()async{
    var response=await ApiConfig().getPersonalDetailOfUser();
    if(response!=null){
      userPersonalDetailModal.value=response;
      // debugPrint("1111111111111111111111111111111");
      // debugPrint(response.toString());
      // debugPrint( userPersonalDetailModal.value!.user!.name.toString());
      // debugPrint( userPersonalDetailModal.value!.user.toString());
    }
  }

}