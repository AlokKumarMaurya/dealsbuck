import 'dart:convert';

import 'package:dealsbuck/screens/persistent_tab.dart';
import 'package:dealsbuck/screens/resetPasswordScreen.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

class VerifyAccount extends StatefulWidget {
  VerifyAccount(
      {Key? key, required this.isFromForgetScreen, required this.phone})
      : super(key: key);
  bool isFromForgetScreen;
  String phone = "";

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  TextEditingController otp = TextEditingController();
  bool loader = false;

  verifyOtp() async {
    print("362154376" + widget.phone.toString());
    setState(() {
      loader = true;
    });
    Map data = {'mobile_no': widget.phone, 'otp': otp.text};
    print(data);
    try {
      var response = await http.post(Uri.parse(verify_otpUrl), body: data);
      var res = await json.decode(response.body);
      var msg = res['message'].toString();
      print(msg);
      print(response.statusCode);
      if (msg == 'Success') {
        Fluttertoast.showToast(msg: msg);

        if (widget.isFromForgetScreen) {
          Fluttertoast.showToast(msg: "Otp Verified");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen()),
          );
          setState(() {
            loader = false;
            otp.clear();
          });
        } else {
          Fluttertoast.showToast(msg: "registration Successfull");
          var token = await res['token'].toString();
          HelperFunction.saveuserLoggedInSharedPreference(true);
          HelperFunction.saveToken(token);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersistentTab()),
          );
          setState(() {
            otp.clear();
            loader = false;
          });
        }
      } else {
        Fluttertoast.showToast(msg: msg);
        setState(() {
          loader = false;
          otp.clear();
        });
      }
    } finally {
      setState(() {
        loader = false;
      });
    }
  }

  requestOtp() async {
    print(widget.phone.toString());
    var response =
        await http.post(Uri.parse("$request_otpUrl/${widget.phone}"));
    var res = await json.decode(response.body);
    var msg = res["message"].toString();
    if (msg == "OTP sent successfully") {
      Fluttertoast.showToast(msg: msg);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) =>  VerifyAccount( isFromForgetScreen: false,)));
      //
      // setState((){
      //   loader=false;
      //   Email.clear();
      //   UserName.clear();
      //   Password.clear();
      //   Dateinput.clear();
      // });

    } else {
      Fluttertoast.showToast(msg: msg);
      // setState(() {
      //   loader = false;
      //   Email.clear();
      //   UserName.clear();
      //   Password.clear();
      //   Dateinput.clear();
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.phone.toString() + "38716248715297162");
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 110, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "VERIFY",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff001527)),
                  ),
                  Text("YOUR ACCOUNT",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff001527))),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Please enter verification code \n   sent to your Phone no.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff001527),
                      ),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text("Verification Code",
                style: TextStyle(fontSize: 16, color: Color(0xff001527))),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Pinput(
                length: 4,
                controller: otp,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: loader != true
                  ? ElevatedButton(
                      onPressed: () {
                        verifyOtp();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      child: Text(
                        "submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    requestOtp();
                  },
                  child: Text("Resend Opt"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// Widget darkRoundedPinPut() {
//   return PinPut(
//     eachFieldWidth: 50.0,
//     eachFieldHeight: 50.0,
//     withCursor: true,
//     fieldsCount: 5,
//     controller: _pinPutController,
//     eachFieldMargin: EdgeInsets.symmetric(horizontal: 10),
//     onSubmit: (String pin) => _showSnackBar(pin),
//     submittedFieldDecoration: BoxDecoration(
//       color: Colors.green[800],
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     selectedFieldDecoration: BoxDecoration(
//       color: Colors.green[800],
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     followingFieldDecoration: BoxDecoration(
//       color: Colors.green[800],
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     pinAnimationType: PinAnimationType.rotation,
//     textStyle: TextStyle(color: Colors.white,
//         fontSize: 20.0,
//         height: 1),
//   );
// }

}
