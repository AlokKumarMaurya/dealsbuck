import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../utils/internetNotConnected.dart';
import 'appBar.dart';



class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String dropdownvalue = 'Today';

  // List of items in our dropdown menu
  var items = [
    'Today',
    'Tomorrow',
    'Yesterday',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

            body: Column(
              children: [
                CustomAppBar("Wallet", IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.ellipsis_vertical,
                    color: Color(0xff001527),
                  ),
                ), Container(width: 40,)),
                Visibility(
                    visible: Provider.of<InternetConnectionStatus>(context) == InternetConnectionStatus.disconnected,
                    child: InternetNotAvailable()),
                Padding(
                  padding:
                  EdgeInsets.only(top: 15, left: 5, right: 5,),
                  child: Column(
                    children: [
                      // Image.asset("assets/wallet_card.jpg"),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 3, right: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Transactions", style: TextStyle(color: Color(0xff001527)),),
                            // Row(
                            //   children: [
                            //     Text("Today"),
                            //     Icon(Icons.arrow_drop_down_sharp)
                            //   ],
                            // ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                value: dropdownvalue,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                alignment: AlignmentDirectional.bottomEnd,
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items, style: TextStyle( color: Color(0xff001527), fontSize: 12),),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.grey,))),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Withdraw amount", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xff001527)),),
                                Text("+\u{20B9}100", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("12 Jan, 09:13 pm", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                Text("Ref ID : 123456789", style: TextStyle(color: Colors.grey, fontSize: 12),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      side: BorderSide(color: Color(0xffed1b24), width: 1),
                    ),
                    child: Text("REDEEM COINS", style: TextStyle(color: Color(0xffed1b24), fontWeight: FontWeight.bold, fontSize: 18),)),
              ],
            )));
  }
}