import 'package:dealsbuck/screens/homeScreens/home_page_screen.dart';
import 'package:dealsbuck/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:toon_tv/main.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  late List<Widget> _pages;
  int _activepage = 0;

  @override
  Widget build(BuildContext context) {
    _pages = [
      //Page 1
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/6,),
           SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Image.asset("assets/page1.jpg"),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/8,),
          const Text('Discover restaurants\n near you',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('We make it simple to find a food for you.\n enter your address and let us do the rest.',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
           SizedBox(
            height:  MediaQuery.of(context).size.height/13
          ),
        ],
      ),

      //Page 2
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/6,),
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Image.asset("assets/diffrent_food.png"),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/8,),
          const Text('Collection of different \n cuisines',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('We have wide range of dishes. You can \n enjoy your favourite dishes with us.',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height:  MediaQuery.of(context).size.height/13
          ),
        ],
      ),

      //Page 3
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/6,),
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Image.asset("assets/fast_delivery.gif"),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/8,),
          const Text('Delivered quickly at \n your place',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('We provide door to door services in mean \n time with best quality of food.',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height:  MediaQuery.of(context).size.height/13
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
children: [
  TextButton(onPressed: (){
    Get.offAll(LoginPage());
  }, child:Text("Continue",style: TextStyle(
    fontSize: 22,
    color: Colors.red
  ),),
  ),
  SizedBox(width:MediaQuery.of(context).size.width/3 ,)
],          )
        ],
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            right: 0,
            left: 0,
            child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    _activepage = value;
                  });
                },
                children: _pages
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomPagination(
              totalPage: _pages.length,
              activePage: _activepage,
            ),
          ),
        ],
      ),
    );
  }
}


class BottomPagination extends StatelessWidget {
  const BottomPagination({super.key, required this.totalPage, required this.activePage});
  final int activePage;
  final int totalPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPage, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            width: activePage == index ? 15 : 5,
            height: 5,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: activePage == index ? Colors.redAccent : Colors.grey,
                borderRadius: BorderRadius.circular(5)
            ),
          );
        }
        ),
      ),
    );
  }
}