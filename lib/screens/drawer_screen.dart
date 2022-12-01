import 'package:dealsbuck/screens/contact_us_screen.dart';
import 'package:dealsbuck/screens/membership_screen.dart';
import 'package:dealsbuck/screens/my_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 10),
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
                        Text(
                          "Claudia Alves",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text("hello@demo.com",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400)),
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
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              leading: Icon(Icons.edit),
              minLeadingWidth: 1,
              title: Text("Edit Profile"),
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
              leading: Icon(CupertinoIcons.profile_circled),
              title: Text("Username"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.mail),
              title: Text("E-mail"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.lock),
              title: Text("Password"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Padding(
                padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey))
              ),
            ),),


            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Preferences",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              leading: Icon(Icons.notifications_rounded),
              minLeadingWidth: 1,
              title: Text("Notification"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.people_alt),
              title: Text("Invite Friends"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.wallet),
              title: Text("Wallet"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.reviews),
              title: Text("My Reviews"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              minLeadingWidth: 1,
              minVerticalPadding: 1,
              leading: Icon(Icons.card_membership),
              title: Text("Membership"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MembershipScreen()),
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
                        bottom: BorderSide(width: 0.5, color: Colors.grey))
                ),
              ),),


            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Account",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
              EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              leading: Icon(Icons.help),
              minLeadingWidth: 1,
              title: Text("Help Center"),
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
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
