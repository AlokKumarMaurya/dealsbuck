import 'dart:convert';

import 'package:dealsbuck/screens/persistent_tab.dart';
import 'package:dealsbuck/screens/signup_screen.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:dealsbuck/utils/urlsConstant.dart';
import 'package:dealsbuck/validation_check/validationCheck.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as Http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/dealsbuck.png"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff001527)),
                  ),
                  Text(
                    "Sign in to continue",
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ],
              ),
            ),
            bottomWidget()
          ],
        ),
      ),
    );
  }
}

class bottomWidget extends StatefulWidget {
  const bottomWidget({Key? key}) : super(key: key);

  @override
  State<bottomWidget> createState() => _bottomWidgetState();
}

class _bottomWidgetState extends State<bottomWidget> with InputValidationMixin {
  bool value = false;
  final TextEditingController loginId = TextEditingController();
  final TextEditingController loginPass = TextEditingController();
  final loginFormGlobalKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool loader = false;
  bool rememberMe = false;

  login() async {
    setState(() {
      loader = true;
      rememberMe
          ? HelperFunction.saveuserLoggedInSharedPreference(rememberMe)
          : HelperFunction.saveuserLoggedInSharedPreference(rememberMe);
    });
    Map data = {
      'email': loginId.text.toString(),
      'password': loginPass.text.toString()
    };

    try {
      print("DATA----------------$data");
      var response = await Http.post(Uri.parse(loginUrl), body: data);
      print(response);
      var res = await json.decode(response.body);
      print(res);
      var msg = res["message"].toString();

      if (msg == "User Logged In Successfully") {
        Fluttertoast.showToast(msg: "Login successful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersistentTab()),
        );
        HelperFunction.saveuserLoggedInSharedPreference(true);
        var token = res["token"].toString();
        var username = res["user"]["name"];
        var email = res["user"]["email"];
        print(username.toString());
        print(email.toString());
        await HelperFunction.saveUserName(username.toString());
        await HelperFunction.saveEmailId(email.toString());
        await HelperFunction.saveToken(token);
        var temp = await HelperFunction.getToken();
        print("tockennnnnnnnnnnnnnnnnnn$temp");

        setState(() {
          loader = false;
          loginId.clear();
          loginPass.clear();
        });
      } else {
        Fluttertoast.showToast(msg: msg);
        setState(() {
          loader = false;
          loginId.clear();
          loginPass.clear();
        });
      }
    } finally {
      loader = false;
    }
  }

  @override
  void initState() {
    print("37152974815629748");
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.red.shade800,
          //color: Color(0xffc51105ff),
        ),
        child: Form(
          key: loginFormGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email /Phone No.",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              TextFormField(
                  controller: loginId,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: Colors.white),
                          borderRadius: BorderRadius.zero),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 4, color: Color(0xff001527)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xff001527))),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xff001527))),
                      hintText: "hello@demo.com",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Colors.black)),
                  validator: (Email) {
                    if (isUserValid(Email!))
                      return null;
                    else
                      return 'Enter a valid username';
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: loginPass,
                  obscureText: !_passwordVisible,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(12),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 4, color: Color(0xff001527)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 4, color: Colors.white),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xff001527))),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xff001527))),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 18,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Colors.black)),
                  validator: (Password) {
                    if (isUserValid(Password!))
                      return null;
                    else
                      return 'Enter a valid Password';
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          activeColor: Color(0xff001527),
                          value: this.value,
                          onChanged: (bool? value) {
                            setState(() {
                              this.value = value!;
                              rememberMe = true;
                            });
                            BorderSide(width: 4);
                          },
                          side: BorderSide(width: 2, color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                        ),
                      ),
                      Text(
                        "Remember me",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ForgotPasswordPage()),
                      // );
                    },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(5, 5),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: loader != true
                    ? ElevatedButton(
                        onPressed: () {
                          if (loginFormGlobalKey.currentState!.validate()) {
                            loginFormGlobalKey.currentState!.save();
                          }
                          login();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Color(0xff001527),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ))
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(5, 5),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff001527),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
