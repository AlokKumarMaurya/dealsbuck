import 'dart:convert';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as Http;
import '../model/membershipResponseModel.dart';
import '../model/purchaseMembershipResponseModel.dart';
import '../utils/urlsConstant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  PurchaseMembershipModel? _purchaseMembershipModel;
  MembershipModel? _membershipModel;
  int? packageId;
  var packageName;

  void initState(){
    // purchaseMembership();
    membership();

  }

  void getpackage() {
    setState((){
      packageName = _membershipModel!.data.packagename;
    });

    print("adgsajkhdgj$packageName");
  }

  // Future<PurchaseMembershipModel?> purchaseMembership() async {
  //   var token = await HelperFunction.getToken();
  //   var response = await Http.get(Uri.parse(purchaseMembershipUrl), headers: {
  //     'Authorization': 'Bearer $token'
  //   });
  //   print(response.body);
  //   setState(() {
  //     _purchaseMembershipModel = PurchaseMembershipModel.fromJson(jsonDecode(response.body));
  //   });
  //   print(_purchaseMembershipModel);
  //   return _purchaseMembershipModel;
  // }
bool loader=false;
  Future<MembershipModel?> membership() async{
    EasyLoading.show(status: 'loading...');
    var token = await HelperFunction.getToken();
    try{
      var response = await Http.get(Uri.parse(membershipUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });
      print(token);
      print("membership response++++++++++"+response.body);
      setState(() {
        _membershipModel = MembershipModel.fromJson(jsonDecode(response.body));
        loader=true;
        getpackage();
      });
      EasyLoading.dismiss();
      return _membershipModel;
    }
    catch (e){
      EasyLoading.dismiss();
    }
  }

  void activateMembership() async{
    var token = await HelperFunction.getToken();
    Map data = {
      'package_id': packageId.toString()
    };
    var response = await Http.post(Uri.parse(activateMembershipUrl), body: data, headers: {
      'Authorization': 'Bearer $token'
    });
    print("activate membership +++++++++++"+ response.body);
    var res = await jsonDecode(response.body);
    var msg = res["message"].toString();
    if(response.statusCode == 200)
      Fluttertoast.showToast(msg: msg);
    membership();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        floatingActionButton:  loader!=false?floatingButtons():SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.45,
                      child: Image.asset("assets/cornerImageRed.png")),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      // Container(margin: EdgeInsets.all(30),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(25),
                      //       color: Colors.white,
                      //     ),
                      //     child: IconButton(
                      //         onPressed: () {}, icon: Icon(Icons.face, color: Color(0xff001527)))),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.45,
                          child: Image.asset("assets/membership.png")),
                    ],
                  ),
                ],
              ),
              bodyWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingButtons() {


    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.white,
        child:
        packageName!=null?
        Container(
          color: Color(0xff001527),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Package Name: ${_membershipModel!.data.packagename}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
              Text("Expiry Date: ${_membershipModel!.data.packageExpiry}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
              Text("Plan: ${_membershipModel!.data.plan}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
            ],
          ),
        ) :
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        fixedSize: Size(130, 55),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        primary: Colors.redAccent),
                    onPressed: () {
                      setState(() {
                        packageId = 1;
                        activateMembership();
                      });
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    label: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("₹199/-", style: TextStyle(color: Colors.white)),
                          Text("yearly", style: TextStyle(color: Colors.white))
                        ])),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Skip for Now",
                  style: TextStyle(color: Color(0xff001527)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        fixedSize: Size(130, 55),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        primary: Color(0xff001527)),
                    onPressed: () {
                      setState(() {
                        packageId = 2;
                        activateMembership();
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "₹999/- Yearly",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("₹2400",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.white))
                        ])),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Limited Time Offer",
                  style: TextStyle(color: Color(0xff001527)),
                )
              ],
            ),
          )
        ])
    );
  }

  Widget bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Purchase Membership",
            style: TextStyle(fontSize: 18, color: Color(0xff001527)),
          ),
          Text(
            "Claim Offer , Deals & Discounts Near You",
            style: TextStyle(fontSize: 13, color: Color(0xff001527)),
          ),
          Divider(
            thickness: 4,
            color: Color(0xffe00b12),
            endIndent: 68,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '5000+',
                      style: TextStyle(fontSize: 18, color: Color(0xff001527)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Deals",
                      style: TextStyle(fontSize: 13, color: Color(0xff001527)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '3000+',
                      style: TextStyle(fontSize: 18, color: Color(0xff001527)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Happy User",
                      style: TextStyle(fontSize: 13, color: Color(0xff001527)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '20+',
                      style: TextStyle(fontSize: 18, color: Color(0xff001527)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "CIties",
                      style: TextStyle(fontSize: 13, color: Color(0xff001527)),
                    )
                  ],
                ),
              ],
            ),
          ),
          GridView.count(
              childAspectRatio: 4 / 5.8,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(choices.length, (index) {
                return Center(
                  child: SelectCard(choice: choices[index]),
                );
              })),
          SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final String icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Off Upto\n50% off', icon: "assets/50%off.png"),
  Choice(title: 'fashion Deal\n150+ Outlets', icon: "assets/fashiondeals.png"),
  Choice(title: 'Spa & Salon\nOff upto 30%', icon: "assets/SpaAndSalon.png"),
  Choice(title: 'Best Deals\non Food', icon: "assets/bestdealsonfood.png"),
  Choice(title: 'Deals on\nStay', icon: "assets/dealsonstay.png"),
  Choice(title: 'And Much\nMore..', icon: "assets/muchmore.png"),
];

class SelectCard extends StatelessWidget {
  const SelectCard({required this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    //  final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Column(
      children: [
        Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                choice.icon,
                fit: BoxFit.cover,
              ),
            )),
        Text(
          choice.title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xff001527)),
        ),
      ],
    );
  }
}
