import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.title,this.appBarWidget, this.appBarWidgetLeft);

  final String title;
  final Widget appBarWidget;
  final Widget appBarWidgetLeft;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xfff8faf7),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBarWidgetLeft,
            Center(
              child: Text(
                title,textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff001527), fontSize: 22),
              ),
            ),

            appBarWidget,

          ],
        ),
      ),
    );
  }
}