import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'appBar.dart';
import 'package:flutter/material.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  String link = "djaghsdjashgdfjkasghragfdashgsdvfs";
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                  "Wallet",
                  Container(
                    width: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff001527),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                // child: Container(
                //   height: x * 0.6,
                //   width: x * 0.6,
                //   color: Colors.black,
                // ),
                child: QrImage(
                  data: link,
                  version: QrVersions.auto,
                  size: x*0.6,
                ),
              ),
              Text("Referral Code", style: TextStyle(fontSize: 15),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedBorder(
                    color: Colors.black,
                    radius: Radius.circular(8),
                    strokeWidth: 1,
                    dashPattern: [
                      5,
                      5,
                    ],
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 20,
                      width: x*0.65,
                      child: Center(child: Text(link, style: TextStyle( fontSize: 12),overflow: TextOverflow.ellipsis, maxLines: 1)),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all()),
                  //   padding: EdgeInsets.symmetric(horizontal: 5),
                  //   height: 25,
                  //   width: x*0.65,
                  //   child: Center(child: Expanded(child: Text(link, style: TextStyle( fontSize: 12),overflow: TextOverflow.ellipsis, maxLines: 1))),
                  // ),
                  SizedBox(width: 5,),
                  InkWell(
                      onTap: (){
                        Fluttertoast.showToast(msg: "Referral Code Copied");
                      },
                      child: Icon(Icons.copy)),
                ],
              ),
              SizedBox(height: 10,),
              Text("Refer your friends to DealsBuck & earn 199 coins", style: TextStyle(color: Color(0xffed1b24), fontSize: 14,fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 20),
                child: Text("You will get 199 coins in your wallet when your friends will purchase membership with your referral code", style: TextStyle(fontSize: 11,),maxLines: 2,textAlign: TextAlign.center,),
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width*0.9,
                child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),),
                    child: Text("Refer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
              ),

            ],
          ),
        ));
  }
}