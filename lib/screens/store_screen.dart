import 'package:dealsbuck/screens/appBar.dart';
import 'package:dealsbuck/screens/persistent_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/backGround.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      // CustomAppBar("Single Pizza Shop", Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              height: 40,
                              // width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.location_solid,
                                      color: Color(0xff001527),
                                    ),
                                    Text(
                                      "Mumbai",
                                      style: TextStyle(
                                          color: Color(0xff001527),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.only(top: 60, right: 35, left: 35),
                        height: 45,
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "What are you looking for",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xffC60808),
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 130.0),
                      //   child: Center(child: Text("Offers & Deals",style:  TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)),
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/storeBannerLogo.png",
                            height: 90,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EL GREECO A 24 HOURS- Udaipur",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Udaipur - 313801",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Open Now 10 am - 10 pm (Today)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff108038)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 20,
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
                                        size: 18,
                                      );
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      child: TabBar(
                        labelColor: Color(0xff001527),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        indicatorColor: Color(0xffed1b24),
                        tabs: [Tab(text: "Offers"), Tab(text: "About")],
                      ),
                    ),
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(children: [
                          offers(),
                          about(),
                        ]),
                      ),
                    ),
                  ],
                ),

                // DefaultTabController(
                //   length: 5,
                //   child: Scaffold(
                //     appBar: AppBar(
                //       bottom: const TabBar(
                //         tabs: [
                //           Tab(icon: Icon(Icons.music_note)),
                //           Tab(icon: Icon(Icons.music_video)),
                //           Tab(icon: Icon(Icons.camera_alt)),
                //           Tab(icon: Icon(Icons.grade)),
                //           Tab(icon: Icon(Icons.email)),
                //         ],
                //       ), // TabBar
                //       title: const Text('GeeksForGeeks'),
                //       backgroundColor: Colors.green,
                //     ), // AppBar
                //     body: const TabBarView(
                //       children: [
                //         Icon(Icons.music_note),
                //         Icon(Icons.music_video),
                //         Icon(Icons.camera_alt),
                //         Icon(Icons.grade),
                //         Icon(Icons.email),
                //       ],
                //     ), // TabBarView
                //   ), // Scaffold
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget offers() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 10),
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
                      width:MediaQuery.of(context).size.width*0.20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width:MediaQuery.of(context).size.width*0.67,
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

  Widget about() {
    return Center(
      child: Text("About"),
    );
  }
}
