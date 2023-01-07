import 'package:dealsbuck/screens/favourite_screen.dart';
import 'package:dealsbuck/screens/homeScreens/home_page_screen.dart';
import 'package:dealsbuck/screens/inbox/inbox_screen.dart';
import 'package:dealsbuck/screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PersistentTab extends StatefulWidget {
  const PersistentTab({Key? key}) : super(key: key);

  @override
  State<PersistentTab> createState() => _PersistentTabState();
}

class _PersistentTabState extends State<PersistentTab> {
  int pageIndex = 0;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      /* PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.rectangle_grid_2x2_fill),
        title: ("Feed"),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),*/
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite_border),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.account_balance_wallet_outlined,
          size: 28,
        ),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person_outline_sharp,
          size: 28,
        ),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomePageScreen(),
      // const FeedScreen(),
      const FavouriteScreen(),
      const WalletScreen(),

      const InboxScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      //backgroundColor: Colors.blue, // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
          /*adjustScreenBottomPaddingOnCurve: true,
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: Colors.white,*/
          border: Border(
        top: BorderSide(width: 3.0, color: Colors.red),
      )),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }
}
