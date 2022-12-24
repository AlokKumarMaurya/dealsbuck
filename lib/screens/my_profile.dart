import 'package:dealsbuck/screens/inbox/inbox_controller.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:dealsbuck/validation_check/validationCheck.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/urlsConstant.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> with InputValidationMixin {
  final inboxController = Get.put(InboxController());
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPassController = TextEditingController();
  final myProfileFormGlobalKey = GlobalKey<FormState>();
  bool loader = false;
  String userEmail = "";

  void getUserEmail() async {
    userEmail = await HelperFunction.getEmailId();
    print(userEmail);
    setState(() {});
  }

  @override
  void initState() {
    getUserEmail();
    print(userEmail);
    super.initState();
  }

  resetPassword(email, newpass, conpass) async {
    setState(() {
      loader = true;
    });
    Map data = {
      'email': inboxController.email.value.toString(),
      'new_password': newpass,
      'confirm_password': conpass,
    };

    print(data);
    var response = await http.post(Uri.parse(reset_passwordUrl), body: data);
    //var res = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loader = false;
        EmailController.clear();
        PasswordController.clear();
        ConfirmPassController.clear();
        UsernameController.clear();
      });
      return Fluttertoast.showToast(msg: "password reset successfully");
    } else
      setState(() {
        loader = false;
        EmailController.clear();
        PasswordController.clear();
        ConfirmPassController.clear();
        UsernameController.clear();
      });
    return Fluttertoast.showToast(
        msg: "The confirm password and new password must match.");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          title: Text(
            "My Profile",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: myProfileFormGlobalKey,
              child: Column(
                children: [
                  Obx(() => TextFormField(
                        readOnly: true,
                        initialValue: inboxController.email.value.toString(),
                        // controller: EmailController,
                        decoration: InputDecoration(
                          hintText: userEmail.toString(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        // textAlignVertical: TextAlignVertical.bottom,
                        validator: (email) {
                          if (isUserValid(email!))
                            return null;
                          else
                            return 'Enter a valid username';
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: inboxController.username.value.toString(),
                    // controller: UsernameController,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Rakesh",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(5))),
                    //textAlignVertical: TextAlignVertical.bottom,
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
                  TextFormField(
                    controller: PasswordController,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(5))),
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
                  TextFormField(
                    controller: ConfirmPassController,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(5))),
                    validator: (password) {
                      if (isPasswordValid(password!))
                        return null;
                      else
                        return 'Enter a valid password';
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                        child: Text(
                      "By continuing, you agree with our Term &\n         Conditions and Privacy Policy",
                      style: TextStyle(fontSize: 12),
                    )),
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: loader != true
                        ? ElevatedButton(
                            onPressed: () {
                              if (myProfileFormGlobalKey.currentState!
                                  .validate()) {
                                myProfileFormGlobalKey.currentState!.save();
                                // use the email provided here
                                resetPassword(
                                    EmailController.text.toString(),
                                    PasswordController.text.toString(),
                                    ConfirmPassController.text.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              "Save",
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
                    height: 75,
                  ),
                  Center(
                    child: Text("if have any issue?"),
                  ),
                  Center(
                    child: SizedBox(
                      height: 30,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Click Here",
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
