import 'dart:async';

import 'package:dealsbuck/screens/login_screen.dart';
import 'package:dealsbuck/screens/persistent_tab.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:get/get.dart';

import '../location_getter/get_usser_current_location.dart';
import '../slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isuserLog = false;
  bool isFirstTime=true;
  GetUserCurrentLocaton _getLocaton = Get.put(GetUserCurrentLocaton());

  void isLog() async {
    isuserLog = await HelperFunction().getuserLoggedInSharedPreference();
    isFirstTime=await HelperFunction().getFirstTime();
  }

  @override
  void initState() {
    _getLocaton.getLocation();

    isLog();
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isuserLog ? PersistentTab() :
                IntroSliderPage()
            )));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width * 0.10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   height: 300,
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(image: AssetImage( "assets/dealbuckText.png"))
                //   ),
                //   child:Column(
                //     // mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       SizedBox(height: 140,),
                //       Text("Discover Delas Near You With",
                //           style: TextStyle(
                //               fontSize: 15,
                //               fontWeight: FontWeight.bold,
                //               color: Color(0xff001527))),
                //
                //       CircularText(
                //         children: [
                //           TextItem(
                //             text: Text(
                //               "loading...",
                //               style: TextStyle(
                //                   fontSize: 12,
                //                   color: Color(0xff001527),
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             space: 8,
                //             startAngle: 90,
                //             startAngleAlignment: StartAngleAlignment.center,
                //             direction: CircularTextDirection.anticlockwise,
                //           ),
                //         ],
                //         radius: 105,
                //         position: CircularTextPosition.inside,
                //         //backgroundPaint: Paint()..color = Colors.grey.shade200,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 100,),

                Stack(children:[
                  Image.asset("assets/dealbuckText.png"),
                  Positioned(
                    left: 50,
                    top: 90,
                    child: Text("Discover Delas Near You With",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff001527))),
                  ),
                ] ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      // color: Color(0xfff8faf7),
                    ),
                    Positioned(
                      //top: 1,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CircularText(
                        children: [
                          TextItem(
                            text: Text(
                              "loading...",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff001527),
                                  fontWeight: FontWeight.w500),
                            ),
                            space: 8,
                            startAngle: 90,
                            startAngleAlignment: StartAngleAlignment.center,
                            direction: CircularTextDirection.anticlockwise,
                          ),
                        ],
                        radius: 105,
                        position: CircularTextPosition.inside,
                        //backgroundPaint: Paint()..color = Colors.grey.shade200,
                      ),
                    )
                  ],
                )
              ],
            ),
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         // Container(
            //         //   height: 60,
            //         //   child: Image.asset(
            //         //     "assets/deal.png",
            //         //     fit: BoxFit.cover,
            //         //   ),
            //         // ),
            //         Container(
            //           width: MediaQuery.of(context).size.width/1.7,
            //           child: Text("Discover Delas Near You With",
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.bold,
            //                   color: Color(0xff001527))),
            //         )
            //       ],
            //     ),
            //     Container(child: Image.asset("assets/icon/icon.png",scale: 6,),),
            //   ],
            // ),
            SizedBox(height: 100,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Made With "),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                    Text(" In "),
                    Image.asset(
                      "assets/Flag.png",
                      scale: 20,
                    )
                  ],
                ),
                Text("Developed by Rank Super Hero ")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
