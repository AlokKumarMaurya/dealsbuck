import 'dart:convert';

import 'package:dealsbuck/validation_check/validationCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dealsbuck/utils/urlsConstant.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> with InputValidationMixin {

  final contactUsForm = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController message = TextEditingController();

  contactUs() async{
    Map data = {
      "name": name.text.toString(),
      "email": email.text.toString(),
      "company": company.text.toString(),
      "category": category.text.toString(),
      "message": message.text.toString(),
    };

    var response = await http.post(Uri.parse(contactUsUrl),body: data);
    var res = await json.decode(response.body);
    print("2001++++++++++++$res");
    var msg = res["message"].toString();
    if(msg == "Our team will reach you soon"){
      Fluttertoast.showToast(msg: msg);
      name.clear();
      email.clear();
      company.clear();
      category.clear();
      message.clear();
    }
    else
      Fluttertoast.showToast(msg: msg);
      name.clear();
      email.clear();
      company.clear();
      category.clear();
      message.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.2, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text("Contact us", style: TextStyle(color: Colors.white, fontSize: 24,),
                  )
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                  child:
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        color: Colors.white,),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Form(
                        key: contactUsForm,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                 height: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                        icon: Icon(Icons.close),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(padding: EdgeInsets.only(left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 25),
                                      child: Text("Get us here", style: TextStyle(fontSize: 20, color: Colors.black),),
                                    ),
                                    Text("Name"),
                                    SizedBox(height: 5,),
                                    SizedBox(
                                      height: 30,
                                      child: TextFormField(
                                        controller: name,
                                        decoration: InputDecoration(
                                            hintText: "Drew Feigh",
                                          errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(0),
                                        ),
                                        textAlignVertical: TextAlignVertical.bottom,
                                        validator: (name){
                                          if(isFieldValid(name!))
                                            return null;
                                          else
                                            return "Please enter name";
                                        },
                                      ),
                                    )
                                  ],
                                ),),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(padding: EdgeInsets.only(left: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Email"),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: email,
                                          decoration: InputDecoration(
                                            hintText: "hello@demo.com",
                                            errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          textAlignVertical: TextAlignVertical.bottom,
                                          validator: (email){
                                            if(isEmailValid(email!))
                                              return null;
                                            else
                                              return "Please enter a valid email";
                                          },
                                        ),
                                      )
                                    ],
                                  ),),
                                Divider(thickness: 1,),
                                Padding(padding: EdgeInsets.only(left: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(height: 5,),
                                      SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: company,
                                          decoration: InputDecoration(
                                            hintText: "Company",
                                            errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          textAlignVertical: TextAlignVertical.bottom,
                                          validator: (company){
                                            if(isFieldValid(company!))
                                              return null;
                                            else
                                              return "Please enter company name";
                                          },
                                        ),
                                      )
                                    ],
                                  ),),

                                Divider(thickness: 1,),
                                Padding(padding: EdgeInsets.only(left: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(height: 5,),
                                      SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: category,
                                          decoration: InputDecoration(
                                            hintText: "Category",
                                            errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                            border: InputBorder.none,
                                            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          textAlignVertical: TextAlignVertical.bottom,
                                          validator: (caterory){
                                            if(isFieldValid(caterory!))
                                              return null;
                                            else
                                              return "Please enter caterory";
                                          },
                                        ),
                                      )
                                    ],
                                  ),),

                                Divider(thickness: 1,),
                                Padding(padding: EdgeInsets.only(left: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(height: 5,),
                                      SizedBox(
                                        height: 120,
                                        child: TextFormField(
                                          controller: message,
                                          decoration: InputDecoration(
                                              hintText: "Message",
                                            errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                              border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                          ),
                                          textAlignVertical: TextAlignVertical.bottom,
                                          maxLines: 5,
                                          validator: (msg){
                                            if(isFieldValid(msg!))
                                              return null;
                                            else
                                              return "Please enter message";
                                          },
                                        ),
                                      )
                                    ],
                                  ),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.black,
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                              if(contactUsForm.currentState!.validate()){
                                                contactUsForm.currentState!.save();
                                              }
                                              contactUs();
                                          },
                                          icon: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ))),
                                  SizedBox(width: 5,),
                                  Text("SEND", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
