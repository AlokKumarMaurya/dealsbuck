import 'package:dealsbuck/screens/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesProductScreen extends StatefulWidget {
  CategoriesProductScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CategoriesProductScreen> createState() =>
      _CategoriesProductScreenState();
}

class _CategoriesProductScreenState extends State<CategoriesProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: CustomAppBar(
                  widget.title,
                  Container(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      color: Color(0xff001527),
                    ),
                  )),
            ),
            Flexible(child: bodyWidget())
          ],
        ),
      ),
    );
  }

  Widget bodyWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29000000),
                    blurRadius: 4.0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(
                      'assets/pizza.png',
                      width: MediaQuery.of(context).size.width * 0.20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.67,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EL GREECO A 24 HOURS",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.favorite,
                                color: Color(0xffC60808),
                                size: 16,
                              )
                            ],
                          ),
                          Text(
                            "Any Menu Item.",
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BUY 1 GET 1 FREE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffC60808)),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                height: 14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder:
                                        (BuildContext contex, int index) {
                                      return Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 12,
                                      );
                                    }),
                              )
                            ],
                          ),
                          Text(
                            "Dine - in Only",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
