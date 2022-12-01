import 'dart:convert';

import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/getNotificationResponseModel.dart';
import '../utils/convertTimeToAgo.dart';
import '../utils/urlsConstant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  GetNotificationModel? _getNotificationModel;
  String dropdownvalue = 'Short by time';

  // List of items in our dropdown menu
  var items = [
    'Short by time',
    'Short by name',
  ];

  Future<GetNotificationModel?> getNotification() async{
    var lati = await HelperFunction.getLatitude();
    var longi = await HelperFunction.getLongitude();
    var token = await HelperFunction.getToken();

    try{
      // var response = await http.get(Uri.parse(getNotificationUrl+lati+longi), headers: {
      //   'Authorization': 'Bearer $token'
      // });

      var response = await http.get(Uri.parse(getNotificationUrl+"28.55254900/77.35286600"), headers: {
        'Authorization': 'Bearer $token'
      });

      // var res = GetNotificationModel.fromJson(jsonDecode(response.body));
      if(response.statusCode == 200){
        setState(() {
          _getNotificationModel = GetNotificationModel.fromJson(jsonDecode(response.body));
        });
        return _getNotificationModel;
      }
    }catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width * 0.45,
                child: Image.asset("assets/cornerImageRed.png")),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.45,
                child: Image.asset("assets/cornerImageRedBottom.png")),),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  CupertinoIcons.mail_solid,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ))),
                      Text("Notifications", style: TextStyle(fontSize: 24),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(color: Colors.black,indent: 100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){}, child: Text("Mark all read", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),)),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          elevation: 0,
                          value: dropdownvalue,
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          alignment: AlignmentDirectional.bottomEnd,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items, style: TextStyle( color: Colors.black, fontSize: 12),),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                 _getNotificationModel!= null? Expanded(child: ListView.builder(itemCount:_getNotificationModel!.data.length,itemBuilder: (BuildContext context,int index){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.orange,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network("https://dealsbuck.com/"+_getNotificationModel!.data[index].brandImagePath, errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace){
                              return Image.asset("assets/defaultImage.png");
                            },),
                          ),
                        ),
                        title: Text(_getNotificationModel!.data[index].title),
                        subtitle: Text(_getNotificationModel!.data[index].body),
                        trailing: Text(TimeToAgo().convertToAgo(_getNotificationModel!.data[index].notificationTime)),
                        tileColor: Colors.white,
                      ),
                    );
                  })) : Container(child: Center(child: CircularProgressIndicator(),),)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
