import 'package:dealsbuck/screens/Deal%20Buck%20Screen/dealsBuckScreen.dart';
import 'package:dealsbuck/screens/favourite_screen.dart';
import 'package:dealsbuck/screens/feed_screen.dart';
import 'package:dealsbuck/screens/homeScreens/home_page_screen.dart';
import 'package:dealsbuck/screens/inbox/inbox_screen.dart';
import 'package:dealsbuck/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

//updatetetettette
//dsajhgdhsajd
///dharmendra sir chnages
void main() {
  runApp(const DealsBuck());
}

class DealsBuck extends StatelessWidget {
  const DealsBuck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<InternetConnectionStatus>(
      initialData: InternetConnectionStatus.connected,
      create: (_) {
        return InternetConnectionChecker().onStatusChange;
      },
      child: GetMaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        builder: EasyLoading.init(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          "/first": (final context) => const HomePageScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          "/second": (final context) => const FeedScreen(),
          "/third": (final context) => const FavouriteScreen(),
          "/fourth": (final context) => const InboxScreen(),
          "/fifth": (final context) => const DealsBuckScreen(),
        },
      ),
    );
  }
}
