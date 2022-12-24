import 'package:dealsbuck/screens/inbox/inbox_controller.dart';
import 'package:dealsbuck/screens/login_screen.dart';
import 'package:dealsbuck/screens/notifications_screen.dart';
import 'package:dealsbuck/screens/wallet_screen.dart';
import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../contact_us_screen.dart';
import '../invite_screen.dart';
import '../membership_screen.dart';
import '../my_profile.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final inboxController = Get.put(InboxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 10),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.orange,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/profile1.png'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              inboxController.username.value.toString(),
                              style: TextStyle(
                                  color: Color(0xff001527),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5),
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        Obx(() => Text(inboxController.email.value.toString(),
                            style: TextStyle(
                                color: Color(0xff001527),
                                fontSize: 10,
                                fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Information",
                style: TextStyle(fontSize: 18, color: Color(0xff001527)),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              leading: Icon(Icons.edit, color: Color(0xff001527)),
              minLeadingWidth: 1,
              title: Text(
                "Edit Profile",
                style: TextStyle(color: Color(0xff001527)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(CupertinoIcons.profile_circled,
                  color: Color(0xff001527)),
              title:
                  Text("Username", style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.mail, color: Color(0xff001527)),
              title: Text("E-mail", style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.lock, color: Color(0xff001527)),
              title:
                  Text("Password", style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Preferences",
                style: TextStyle(fontSize: 18, color: Color(0xff001527)),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              leading:
                  Icon(Icons.notifications_rounded, color: Color(0xff001527)),
              minLeadingWidth: 1,
              title: Text("Notification",
                  style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.people_alt, color: Color(0xff001527)),
              title: Text("Invite Friends",
                  style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => InviteScreen()));
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.wallet, color: Color(0xff001527)),
              title: Text("Wallet", style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WalletScreen()));
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.reviews, color: Color(0xff001527)),
              title: Text("My Reviews",
                  style: TextStyle(color: Color(0xff001527))),
              onTap: () {},
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.card_membership, color: Color(0xff001527)),
              title: Text("Membership",
                  style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MembershipScreen()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Account",
                style: TextStyle(fontSize: 18, color: Color(0xff001527)),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              leading: Icon(Icons.help, color: Color(0xff001527)),
              minLeadingWidth: 1,
              title: Text("Help Center",
                  style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUs()),
                );
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.logout, color: Color(0xff001527)),
              title:
                  Text("Log Out", style: TextStyle(color: Color(0xff001527))),
              onTap: () {
                setState(() {
                  HelperFunction.saveuserLoggedInSharedPreference(false);
                });
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
                    },
                  ),
                  (_) => false,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
