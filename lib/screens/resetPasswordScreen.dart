import 'package:dealsbuck/screens/login_screen.dart';
import 'package:dealsbuck/validation_check/validationCheck.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils/sharedPreference.dart';
import '../utils/urlsConstant.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with InputValidationMixin {
  final resetPassFromGlobalKey = GlobalKey<FormState>();

  //final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPassController = TextEditingController();
  bool loader = false;

  resetPassword(newpass, conpass) async {
    setState(() {
      loader = true;
    });
    Map data = {
      'email': await HelperFunction.getEmailId(),
      'new_password': newpass,
      'confirm_password': conpass,
    };
    print(data);
    var response = await http.post(Uri.parse(reset_passwordUrl), body: data);
    //var res = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      setState(() {
        loader = false;
        PasswordController.clear();
        ConfirmPassController.clear();
      });
      return Fluttertoast.showToast(msg: "password reset sussesfully");
    } else
      setState(() {
        loader = false;
        PasswordController.clear();
        ConfirmPassController.clear();
      });
    return Fluttertoast.showToast(
        msg: "The confirm password and new password must match.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Form(
          key: resetPassFromGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Reset",
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
                      "New Password",
                      style: TextStyle(fontSize: 15, color: Color(0xff001527)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
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
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.9,
                child: loader != true
                    ? ElevatedButton(
                        onPressed: () {
                          if (resetPassFromGlobalKey.currentState!.validate()) {
                            resetPassFromGlobalKey.currentState!.save();
                            // use the email provided here
                            resetPassword(PasswordController.text.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
