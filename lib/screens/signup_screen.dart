import 'dart:convert';

import 'package:dealsbuck/screens/login_screen.dart';
import 'package:dealsbuck/screens/verify_account_screen.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dealsbuck/validation_check/validationCheck.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "Create new",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Color(0xff001527)),
                  ),
                  Text("Account",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Color(0xff001527))),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Text(
                          "Already Registered?",
                          style: TextStyle(fontSize: 15, color: Color(0xff001527)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(5, 5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          child: Text(
                            " Log in here.",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff001527),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              signupfield()
            ],
          ),
        ),
      ),
    );
  }
}

class signupfield extends StatefulWidget {
  const signupfield({Key? key}) : super(key: key);

  @override
  State<signupfield> createState() => _signupfieldState();
}

class _signupfieldState extends State<signupfield> with InputValidationMixin {
  final TextEditingController Dateinput = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Phone = TextEditingController();
  final TextEditingController UserName = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final regFormGlobalKey = GlobalKey<FormState>();
  bool loader=false;
  void initState() {
    Dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  register(String username, email, birthdate, password, phone) async {
    setState((){ loader=true;});

    Map data = {
      'name': username,
      'email': email,
      'password': password,
      'dob': birthdate,
      'mobile_no': phone
    };
    print(data);
    var response = await http.post(Uri.parse(registerUrl), body: data);
    print("response>>>>>>>>>>>${response.body}");
    var res = await json.decode(response.body);
    var msg = res["message"].toString();
    try{
      if (msg == "User Created & OTP sent successfully") {
        Fluttertoast.showToast(msg: "Otp sent Successfully");
        var token = res["token"].toString();
        await HelperFunction.saveToken(token);
        await HelperFunction.saveUserName(username);
        await HelperFunction.saveEmailId(email);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  VerifyAccount( isFromForgetScreen: false,phone: phone,)));
        // requestOtp();
      }else {
        res["errors"]["mobile_no"]!=null?Fluttertoast.showToast(msg: res["errors"]["mobile_no"].toString()):Container();
        res["errors"]["email"]!=null?Fluttertoast.showToast(msg: res["errors"]["email"].toString()):Container();
      }
    }
    finally{
      setState(() {
        loader = false;
      });
    }
  }

  // requestOtp() async{
  //   Map data = {
  //     'email': Email.text,
  //   };
  //   await HelperFunction.saveEmailId(Email.text.toString());
  //   print(data);
  //   var response = await http.post(Uri.parse(request_otpUrl), body: data);
  //   var res = await json.decode(response.body);
  //   var msg = res["message"].toString();
  //   if (msg == "OTP sent successfully"){
  //     Fluttertoast.showToast(msg: msg);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) =>  VerifyAccount( isFromForgetScreen: false,)));
  //
  //     setState((){
  //       loader=false;
  //       Email.clear();
  //       UserName.clear();
  //       Password.clear();
  //       Dateinput.clear();
  //     });
  //
  //   }
  //   else{
  //     Fluttertoast.showToast(msg: msg);
  //     setState(() {
  //       loader = false;
  //       Email.clear();
  //       UserName.clear();
  //       Password.clear();
  //       Dateinput.clear();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Form(
        key: regFormGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NAME", style: TextStyle( color: Color(0xff001527)),),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: UserName,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                hintText: "Jiara Martins",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,),
                    borderRadius: BorderRadius.zero),
              ),
              validator: (username) {
                if (isUserValid(username!))
                  return null;
                else
                  return 'Enter a valid username';
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text("EMAIL", style: TextStyle( color: Color(0xff001527))),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: Email,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,),
                    borderRadius: BorderRadius.zero),
                hintText: "hello@demo.com",
              ),
              validator: (email) {
                if (isEmailValid(email!))
                  return null;
                else
                  return 'Enter a valid email address';
              },
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 5,
            ),
            Text("Phone no.", style: TextStyle( color: Color(0xff001527))),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: Phone,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,),
                    borderRadius: BorderRadius.zero),
                hintText: "Phone number",
              ),
              validator: (phone) {
                if (isPhoneValid(phone!))
                  return null;
                else
                  return 'Enter a valid Phone number';
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text("PASSWORD", style: TextStyle( color: Color(0xff001527))),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: Password,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,),
                    borderRadius: BorderRadius.zero),
                hintText: "Password",
              ),
              obscureText: true,
              validator: (password) {
                if (isPasswordValid(password!))
                  return null;
                else
                  return 'Enter a valid password';
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text("DATE OF BIRTH", style: TextStyle( color: Color(0xff001527))),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              controller: Dateinput,
              //editing controller of this TextField

              decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_today_outlined),
                //icon of text field
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,),
                    borderRadius: BorderRadius.zero),
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1930),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime.now());

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    Dateinput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
              validator: (date) {
                if (isDateValid(date!))
                  return null;
                else
                  return 'Enter a valid Date';
              },
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: loader!=true?ElevatedButton(
                  onPressed: () {
                    if (regFormGlobalKey.currentState!.validate()) {
                      regFormGlobalKey.currentState!.save();
                      // use the email provided here
                      register(UserName.text.toString(), Email.text.toString(),
                          Dateinput.text.toString(), Password.text.toString(), Phone.text.toString());
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const LoginPage()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade800,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(
                    "sign up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )):Center(child: CircularProgressIndicator(color: Colors.red,),),
            ),
          ],
        ),
      ),
    );
  }
}

// mixin InputValidationMixin {
//   bool isPasswordValid(String password) => password.length == 8;
//
//   bool isEmailValid(String email) {
//     return RegExp(
//             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}'
//             r'\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//         .hasMatch(email);
//   }
//
//   bool isUserValid(String username) =>
//       username.length >= 3 && username.isNotEmpty;
//
//   bool isDateValid(String date) => date.isNotEmpty;
// }
