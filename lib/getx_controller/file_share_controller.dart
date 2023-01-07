import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class FileShareController extends GetxController{


  void shareFileFunction()async{
    await FlutterShare.share(
        title: 'DealsBuck App',
        text: 'DealsBuck App',
        linkUrl: 'https://dealsbuck.com/',
        chooserTitle: 'Share dealsbuck app'
    );
  }


}