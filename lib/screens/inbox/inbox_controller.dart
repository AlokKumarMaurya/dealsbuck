import 'package:dealsbuck/utils/sharedPreference.dart';
import 'package:get/get.dart';

class InboxController extends GetxController{

  final username = "Username".obs;
  final email = "Email@gmail.com".obs;

  getUserDetails() async{
    var name = await HelperFunction.getUserName();
    var mail = await HelperFunction.getEmailId();

    username(name);
    email(mail);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUserDetails();
    super.onInit();
  }

}