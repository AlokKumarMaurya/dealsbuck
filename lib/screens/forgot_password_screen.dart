import 'dart:convert';
import 'package:dealsbuck/screens/login_screen.dart';
import 'package:dealsbuck/screens/verify_account_screen.dart';
import 'package:dealsbuck/validation_check/validationCheck.dart';
import 'package:flutter/material.dart';
import 'package:dealsbuck/validation_check/validationCheck.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/sharedPreference.dart';
import '../utils/urlsConstant.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with InputValidationMixin {
  final forgetPassFormGlobalKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  bool isFromForgetScreen = true;
  bool loader = false;

  requestOtp() async {
    setState(() {
      loader = true;
    });
    // Map data = {
    //   'mobile_no': phone.text.toString(),
    // };
    // await HelperFunction.saveEmailId(phone.text.toString());
    // print(data);
    try{

      var response = await http.post(Uri.parse("$request_otpUrl/${phone.text.toString()}"));
      var res = await json.decode(response.body);
      var msg = res["message"].toString();
      if (msg == "OTP sent successfully") {
        Fluttertoast.showToast(msg: msg);
        print("3785127635127"+phone.text.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerifyAccount(isFromForgetScreen: isFromForgetScreen, phone: phone.text.toString())));
        Future.delayed(Duration(milliseconds: 500), (){
          setState(() {
            loader = false;
            phone.clear();
          });
        });
      } else {
        Fluttertoast.showToast(msg: msg);
        setState(() {
          loader = false;
         phone.clear();
        });
      }
    }catch(e){
      print(e);
      setState(() {
        loader = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Form(
          key: forgetPassFormGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Forgot",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff001527)),
                    ),
                    Text("Password",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff001527))),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Enter account linked Phone no",
                      style: TextStyle(fontSize: 15, color: Color(0xff001527)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text("Phone no.", style: TextStyle(color: Color(0xff001527))),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: phone,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(14),
                  // focusedBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(width: 1, color: Colors.blue),
                  //     borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.zero),
                  hintText: "Phone no.",
                ),
                validator: (phone) {
                  if (isPhoneValid(phone!))
                    return null;
                  else
                    return "Enter a valid Phone number";
                },
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child:
                loader != true ?
                ElevatedButton(

                        onPressed: () {
                          if (forgetPassFormGlobalKey.currentState!
                              .validate()) {
                            forgetPassFormGlobalKey.currentState!.save();

                            requestOtp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                        child: Text(
                          "send",
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
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Need Help ?",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff001527),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(5, 5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft),
                      child: Text(
                        "Help@dealsbucks.com",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff001527),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   style: TextButton.styleFrom(
                    //       padding: EdgeInsets.zero,
                    //       minimumSize: Size(5, 5),
                    //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //       alignment: Alignment.centerLeft),
                    //   child: Text(
                    //     "Call - 011-220-22020",
                    //     style: TextStyle(
                    //         fontSize: 18,
                    //         color: Color(0xff001527),
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
