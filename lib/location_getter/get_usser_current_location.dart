import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GetLocaton extends GetxController{
  var lat=0.0.obs;
  var long=0.0.obs;


  @override
  void onInit() {
    getLocation();
    // TODO: implement onInit
    super.onInit();
  }

  void getLocation()async{
    var permission=await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        Geolocator.openAppSettings();
    }
    }
    if(permission != LocationPermission.denied && permission !=LocationPermission.deniedForever){
      var temp=await Geolocator.getCurrentPosition();
      lat.value=temp.latitude;
      long.value=temp.longitude;
      debugPrint(lat.value.toString());
      debugPrint(long.value.toString());
      debugPrint("long.value.toString()long.value.toString()");
    }
  }

}