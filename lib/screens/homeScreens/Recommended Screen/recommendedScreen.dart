import 'package:dealsbuck/screens/appBar.dart';
import 'package:flutter/material.dart';

class recommendedScreen extends StatefulWidget {
  const recommendedScreen({Key? key}) : super(key: key);

  @override
  State<recommendedScreen> createState() => _recommendedScreenState();
}

class _recommendedScreenState extends State<recommendedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/backGround.png"),
                CustomAppBar("Single Pizza Shop", Container(), Container()),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.only(top: 60, right: 35, left: 35),
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "What are you looking for",prefixIcon: Icon(Icons.search,color: Color(0xffC60808),)
                    ),
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top: 130.0),
                  child: Center(child: Text("Offers & Deals",style:  TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)),
                ),
              ],
            ),

            bodyWidget()


          ],
        ),
      ),
    );
  }
  Widget bodyWidget(){
    return Expanded(child: ListView.builder(itemCount:10,itemBuilder: (BuildContext context,int index){
      return  Card(elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.orange,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/pizza.png'),
            ),
          ),
          title: Text("Pizza Da Lo"),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Buy 1 get 1 free",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
              Text("Any Menu Items."),
            ],
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Dine - in Daily",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                  Container(margin: EdgeInsets.all(5),padding:EdgeInsets.symmetric(horizontal: 5) ,height: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
                    child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap:true,physics: NeverScrollableScrollPhysics(),itemCount: 5,itemBuilder: (BuildContext contex,int index){
                      return Icon(Icons.star,color: Colors.orange,size: 18,);
                    }),
                  )
                ],
              ),
              Icon(Icons.favorite,color: Color(0xffC60808),)
            ],
          ),
          tileColor: Colors.white,
        ),
      );
    }));
  }
}