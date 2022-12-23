import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoder/geocoder.dart';
class GetUserCurrentLocaton extends GetxController{
  var lat=0.0.obs;
  var long=0.0.obs;


  @override
  void onInit() {
    getLocation();
    // TODO: implement onInit
    super.onInit();
  }

  Future<bool> getLocation()async{
    var permission=await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        SystemNavigator.pop();
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
    return true;
  }


  Future<String> searchLoacation() async {




    const kGoogleApiKey = 'API_KEY';

    void onError( response) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }
    // prediction?
    var  p = await PlacesAutocomplete.show(
      context: Get.context!,
      // apiKey: "AIzaSyAxx2cI6NVwCr9udAWg4NrPxGiyiajQ9tg",
      apiKey: "AIzaSyCSiSdgeCctNGs33wqaPUIiFvXj5S2OQDw",
      onError: onError,
      mode: Mode.fullscreen, // or Mode.fullscreen
      language: 'IN',

      // components: ,
    );
    var addresses = await Geocoder.local.findAddressesFromQuery(p!.description);
    var first = addresses.first;
    debugPrint("${first.featureName} : ${first.coordinates}");
lat.value=first.coordinates.latitude;
long.value=first.coordinates.longitude;




return "test";


  }

}